import 'dart:async';
import 'package:logger/logger.dart';
import 'package:web3_ai_assistant/repositories/portfolio/portfolio_repository.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/services/market_data/market_data_service.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_price.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  
  PortfolioRepositoryImpl({
    required MarketDataService marketDataService,
    required Web3Service web3Service,
    Logger? logger,
  }) : _marketDataService = marketDataService,
       _web3Service = web3Service,
       _logger = logger ?? Logger();
       
  final MarketDataService _marketDataService;
  final Web3Service _web3Service;
  final Logger _logger;
  
  List<PortfolioToken> _currentPortfolio = [];
  StreamController<List<PortfolioToken>>? _portfolioController;
  StreamSubscription<TokenPrice>? _priceSubscription;
  String? _currentWalletAddress;

  @override
  Stream<List<PortfolioToken>> get portfolioStream => 
      _portfolioController?.stream ?? const Stream.empty();

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

      // Extract symbols for price fetching
      final symbols = tokenBalances.map((token) => '${token.symbol}USDT').toList();
      
      // Get current prices for all tokens
      final tokenPrices = await _marketDataService.getTokenPrices(symbols);
      final priceMap = {for (final price in tokenPrices) price.symbol: price};
      
      // Transform balances and prices into portfolio tokens
      final portfolioTokens = <PortfolioToken>[];
      for (final balance in tokenBalances) {
        final symbol = '${balance.symbol}USDT';
        final price = priceMap[symbol];
        
        final balanceDouble = balance.balance.toDouble() / 
            BigInt.from(10).pow(balance.decimals).toDouble(); // Convert from wei to readable format
        
        if (price != null) {
          _logger.i('Creating portfolio token: ${balance.symbol}, Balance: $balanceDouble, Price: ${price.price}');
          
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
            price: 0.0, // No price data available
            change24h: 0.0,
            changePercent24h: 0.0,
            totalValue: 0.0, // Can't calculate without price
            logoUri: balance.logoUri,
            lastUpdated: DateTime.now(),
          );
          portfolioTokens.add(portfolioToken);
        }
      }
      
      // Sort by total value (descending)
      portfolioTokens.sort((a, b) => b.totalValue.compareTo(a.totalValue));
      
      _currentPortfolio = portfolioTokens;
      _portfolioController?.add(_currentPortfolio);
      
      _logger.i('Portfolio fetched successfully. ${portfolioTokens.length} tokens found.');
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
      return; // Already subscribed
    }
    
    await unsubscribeFromPortfolioUpdates();
    
    _currentWalletAddress = walletAddress;
    _portfolioController ??= StreamController<List<PortfolioToken>>.broadcast();
    
    // Subscribe to price updates for all tokens in portfolio
    if (_currentPortfolio.isNotEmpty) {
      final symbols = _currentPortfolio.map((token) => '${token.symbol}USDT').toList();
      _marketDataService.subscribeToMultiplePrices(symbols);
      
      _priceSubscription = _marketDataService.priceStream.listen(
        _handlePriceUpdate,
        onError: (Object error) => _logger.e('Price stream error: $error'),
      );
    }
  }

  @override
  Future<void> unsubscribeFromPortfolioUpdates() async {
    if (_priceSubscription != null) {
      await _priceSubscription!.cancel();
      _priceSubscription = null;
    }
    
    if (_currentPortfolio.isNotEmpty) {
      final symbols = _currentPortfolio.map((token) => '${token.symbol}USDT').toList();
      _marketDataService.unsubscribeFromMultiplePrices(symbols);
    }
    
    _currentWalletAddress = null;
  }

  void _handlePriceUpdate(TokenPrice tokenPrice) {
    // Find the token in current portfolio and update its price
    var hasUpdates = false;
    final updatedPortfolio = _currentPortfolio.map((token) {
      if ('${token.symbol}USDT' == tokenPrice.symbol) {
        hasUpdates = true;
        return token.copyWith(
          price: tokenPrice.price,
          change24h: tokenPrice.change24h,
          changePercent24h: tokenPrice.changePercent24h,
          totalValue: token.balance * tokenPrice.price,
          lastUpdated: tokenPrice.lastUpdated,
        );
      }
      return token;
    }).toList();
    
    if (hasUpdates) {
      // Re-sort by total value
      updatedPortfolio.sort((a, b) => b.totalValue.compareTo(a.totalValue));
      _currentPortfolio = updatedPortfolio;
      _portfolioController?.add(_currentPortfolio);
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
