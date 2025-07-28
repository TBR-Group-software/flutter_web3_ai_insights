import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:web3_ai_assistant/repositories/portfolio/portfolio_repository.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/token_price.dart';
import 'package:web3_ai_assistant/services/binance_rest/binance_rest_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/binance_websocket_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/models/token_ticker.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl({
    required BinanceRestService binanceRestService,
    required BinanceWebSocketService binanceWebSocketService,
    required Web3Service web3Service,
    Logger? logger,
  }) : _binanceRestService = binanceRestService,
       _binanceWebSocketService = binanceWebSocketService,
       _web3Service = web3Service,
       _logger = logger ?? Logger();

  final BinanceRestService _binanceRestService;
  final BinanceWebSocketService _binanceWebSocketService;
  final Web3Service _web3Service;
  final Logger _logger;

  List<PortfolioToken> _currentPortfolio = [];
  StreamController<List<PortfolioToken>>? _portfolioController;
  StreamSubscription<TokenTicker>? _priceSubscription;
  final Map<String, PortfolioToken> _portfolioMap = {};
  final Set<String> _subscribedSymbols = {};
  String? _currentWalletAddress;

  @override
  Stream<List<PortfolioToken>> get portfolioStream => _portfolioController?.stream ?? const Stream.empty();

  @override
  List<PortfolioToken> get currentPortfolio => List.unmodifiable(_currentPortfolio);

  @override
  Future<List<PortfolioToken>> getPortfolio(String walletAddress) async {
    try {
      _logger.i('Fetching portfolio for wallet: $walletAddress');

      // Get token balances from web3 wallet
      final tokenBalances = await _web3Service.getTokenBalances(walletAddress);

      if (tokenBalances.isEmpty) {
        _logger.w('No token balances found for wallet: $walletAddress');
        return [];
      }

      // Extract symbols for price fetching - map to correct Binance symbols
      final symbols = <String>[];
      final symbolMapping = <String, String>{}; // Maps Binance symbol back to original token symbol

      for (final token in tokenBalances) {
        final binanceSymbol = _mapToBinanceSymbol(token.symbol);
        if (binanceSymbol != null) {
          symbols.add(binanceSymbol);
          symbolMapping[binanceSymbol] = token.symbol;
        }
      }

      _logger.i('📊 Requesting REST API prices for ${symbols.length} Binance symbols: $symbols');

      // Get current prices for all tokens via REST API
      final symbolsJson = jsonEncode(symbols);
      final tickers = await _binanceRestService.getTicker24hr(symbols: symbolsJson);
      final priceMap = <String, TokenPrice>{};

      for (final ticker in tickers) {
        final originalSymbol = symbolMapping[ticker.symbol];
        if (originalSymbol != null) {
          // Convert Ticker24hr to TokenPrice domain model
          final tokenPrice = TokenPrice(
            symbol: ticker.symbol,
            price: double.parse(ticker.lastPrice),
            change24h: double.parse(ticker.lastPrice) * (double.parse(ticker.priceChangePercent) / 100),
            changePercent24h: double.parse(ticker.priceChangePercent),
            high24h: double.parse(ticker.highPrice),
            low24h: double.parse(ticker.lowPrice),
            volume24h: double.parse(ticker.volume),
            lastUpdated: DateTime.fromMillisecondsSinceEpoch(ticker.closeTime),
          );
          priceMap[originalSymbol] = tokenPrice;
          _logger.i('💰 REST API price ${ticker.symbol} (\$${ticker.lastPrice}) -> $originalSymbol');
        }
      }

      // Ensure we have prices for all requested tokens
      if (priceMap.isEmpty && symbols.isNotEmpty) {
        _logger.w('No prices received for symbols: $symbols');
      }

      _logger.i('Price map contains: ${priceMap.keys.toList()}');

      // Transform balances and prices into portfolio tokens
      final portfolioTokens = <PortfolioToken>[];
      for (final balance in tokenBalances) {
        final price = priceMap[balance.symbol];

        final balanceDouble =
            balance.balance.toDouble() /
            BigInt.from(10).pow(balance.decimals).toDouble(); // Convert from wei to readable format

        _logger.i(
          'Token ${balance.symbol}: Balance ${balance.balance} wei, Decimals: ${balance.decimals}, Converted: $balanceDouble',
        );

        // Special handling for USDT - it's always worth $1.00
        if (balance.symbol.toUpperCase() == 'USDT') {
          final portfolioToken = PortfolioToken(
            symbol: balance.symbol,
            name: balance.name,
            contractAddress: balance.contractAddress,
            balance: balanceDouble,
            decimals: balance.decimals,
            price: 1, // USDT is pegged to $1
            change24h: 0, // Stable coin doesn't change much
            changePercent24h: 0,
            totalValue: balanceDouble * 1.0,
            logoUri: balance.logoUri,
            lastUpdated: DateTime.now(),
          );
          portfolioTokens.add(portfolioToken);
        } else if (price != null) {
          _logger.i('Creating portfolio token: ${balance.symbol}, Balance: $balanceDouble, Price: \$${price.price}');

          final portfolioToken = PortfolioToken(
            symbol: balance.symbol,
            name: balance.name,
            contractAddress: balance.contractAddress,
            balance: balanceDouble,
            decimals: balance.decimals,
            price: price.price,
            change24h: price.change24h,
            changePercent24h: price.changePercent24h,
            totalValue: balanceDouble * price.price,
            logoUri: balance.logoUri,
            lastUpdated: price.lastUpdated,
          );
          portfolioTokens.add(portfolioToken);
        } else {
          // Add token even without price data so users can see their balance
          _logger.w('No price found for token: ${balance.symbol}, adding with zero price');

          final portfolioToken = PortfolioToken(
            symbol: balance.symbol,
            name: balance.name,
            contractAddress: balance.contractAddress,
            balance: balanceDouble,
            decimals: balance.decimals,
            price: 0, // No price data available
            change24h: 0,
            changePercent24h: 0,
            totalValue: 0, // Can't calculate without price
            logoUri: balance.logoUri,
            lastUpdated: DateTime.now(),
          );
          portfolioTokens.add(portfolioToken);
        }
      }

      // Sort by total value (descending)
      portfolioTokens.sort((a, b) => b.totalValue.compareTo(a.totalValue));

      _currentPortfolio = portfolioTokens;
      
      // Update portfolio map for WebSocket updates
      _portfolioMap.clear();
      for (final token in portfolioTokens) {
        _portfolioMap[token.symbol] = token;
      }

      // Immediately emit to stream for real-time UI updates
      _portfolioController ??= StreamController<List<PortfolioToken>>.broadcast();
      _portfolioController?.add(_currentPortfolio);

      _logger.i('✅ Portfolio fetched with REST API data. ${portfolioTokens.length} tokens found. Stream initialized.');
      return portfolioTokens;
    } catch (e) {
      _logger.e('Error fetching portfolio: $e');
      return [];
    }
  }

  @override
  Future<void> refreshPortfolio(String walletAddress) async {
    await getPortfolio(walletAddress);
  }

  @override
  Future<void> subscribeToPortfolioUpdates(String walletAddress) async {
    if (_currentWalletAddress == walletAddress && _priceSubscription != null) {
      _logger.i('Already subscribed to portfolio updates for $walletAddress');
      return; // Already subscribed
    }

    await unsubscribeFromPortfolioUpdates();

    _currentWalletAddress = walletAddress;
    _portfolioController ??= StreamController<List<PortfolioToken>>.broadcast();

    _logger.i('🚀 Starting portfolio subscription for wallet: $walletAddress');

    // Subscribe to price updates for all tokens in portfolio
    if (_currentPortfolio.isNotEmpty) {
      final symbols = <String>[];
      for (final token in _currentPortfolio) {
        final binanceSymbol = _mapToBinanceSymbol(token.symbol);
        if (binanceSymbol != null) {
          symbols.add(binanceSymbol);
        }
      }

      if (symbols.isNotEmpty) {
        _logger.i('📡 Subscribing to WebSocket price updates for ${symbols.length} symbols: $symbols');
        _binanceWebSocketService.subscribeToSymbols(symbols);
        
        // Track subscribed symbols
        _subscribedSymbols.clear();
        _subscribedSymbols.addAll(symbols);

        _priceSubscription = _binanceWebSocketService.tickerStream.listen(
          _handleTickerUpdate,
          onError: (Object error) => _logger.e('❌ Price stream error: $error'),
        );

        _logger.i('✅ WebSocket subscription active - real-time updates enabled');
      } else {
        _logger.w('⚠️ No valid symbols found for WebSocket subscription');
      }
    } else {
      _logger.w('⚠️ Portfolio is empty - cannot subscribe to price updates');
    }
  }

  @override
  Future<void> unsubscribeFromPortfolioUpdates() async {
    if (_priceSubscription != null) {
      await _priceSubscription!.cancel();
      _priceSubscription = null;
    }

    if (_subscribedSymbols.isNotEmpty) {
      _binanceWebSocketService.unsubscribeFromSymbols(_subscribedSymbols.toList());
      _subscribedSymbols.clear();
    }

    _currentWalletAddress = null;
  }

  void _handleTickerUpdate(TokenTicker ticker) {
    _logger.i('🔄 WebSocket ticker update for ${ticker.symbol}: \$${ticker.price}');

    // Convert TokenTicker to TokenPrice domain model
    final currentPrice = double.parse(ticker.price);
    final changePercent = double.parse(ticker.changePercent);
    final tokenPrice = TokenPrice(
      symbol: ticker.symbol,
      price: currentPrice,
      change24h: currentPrice * (changePercent / 100),
      changePercent24h: changePercent,
      high24h: double.parse(ticker.high),
      low24h: double.parse(ticker.low),
      volume24h: double.parse(ticker.volume),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(ticker.eventTime),
    );

    // Find the matching token by reverse-mapping the Binance symbol
    String? tokenSymbol;
    for (final entry in _portfolioMap.entries) {
      final binanceSymbol = _mapToBinanceSymbol(entry.key);
      if (binanceSymbol == ticker.symbol) {
        tokenSymbol = entry.key;
        break;
      }
    }
    
    if (tokenSymbol != null && _portfolioMap.containsKey(tokenSymbol)) {
      final token = _portfolioMap[tokenSymbol]!;
      _logger.i('💎 REAL-TIME UPDATE: $tokenSymbol price \$${token.price} → \$${tokenPrice.price}');
      
      // Update the token with new price data
      final updatedToken = token.copyWith(
        price: tokenPrice.price,
        change24h: tokenPrice.change24h,
        changePercent24h: tokenPrice.changePercent24h,
        totalValue: token.balance * tokenPrice.price,
        lastUpdated: tokenPrice.lastUpdated,
      );
      
      // Update the map
      _portfolioMap[tokenSymbol] = updatedToken;
      
      // Rebuild the portfolio list from the map
      _currentPortfolio = _portfolioMap.values.toList()
        ..sort((a, b) => b.totalValue.compareTo(a.totalValue));
      
      // CRITICAL: Emit to stream for immediate UI update
      _portfolioController?.add(_currentPortfolio);
      _logger.i('📺 UI UPDATED: Portfolio streamed with WebSocket data - should see in real-time!');
    } else {
      _logger.w(
        '⚠️ No matching token found for ${ticker.symbol} in portfolio: ${_portfolioMap.keys.join(', ')}',
      );
    }
  }

  /// Map Web3 token symbols to valid Binance trading pairs
  String? _mapToBinanceSymbol(String tokenSymbol) {
    switch (tokenSymbol.toUpperCase()) {
      case 'ETH':
        return 'ETHUSDT';
      case 'WETH':
        return 'ETHUSDT'; // WETH uses same price as ETH on Binance
      case 'BTC':
      case 'WBTC':
        return 'BTCUSDT'; // Both BTC and WBTC use BTC price
      case 'USDC':
        return 'USDCUSDT';
      case 'USDT':
        return null; // USDT is the quote currency, no need to fetch its price vs itself
      case 'BNB':
        return 'BNBUSDT';
      case 'ADA':
        return 'ADAUSDT';
      case 'DOT':
        return 'DOTUSDT';
      case 'LINK':
        return 'LINKUSDT';
      case 'UNI':
        return 'UNIUSDT';
      case 'MATIC':
        return 'MATICUSDT';
      case 'AVAX':
        return 'AVAXUSDT';
      case 'SOL':
        return 'SOLUSDT';
      default:
        // For unknown tokens, try adding USDT suffix
        return '${tokenSymbol.toUpperCase()}USDT';
    }
  }

  @override
  void dispose() {
    unsubscribeFromPortfolioUpdates();
    _portfolioController?.close();
    _portfolioController = null;
    _currentPortfolio.clear();
  }
}
