import 'dart:async';
import 'package:web3_ai_assistant/repositories/market/market_repository.dart';
import 'package:web3_ai_assistant/repositories/market/models/market_data.dart';
import 'package:web3_ai_assistant/services/binance_rest/binance_rest_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/binance_websocket_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/models/token_ticker.dart';

class MarketRepositoryImpl implements MarketRepository {
  MarketRepositoryImpl({
    required this.binanceRestService,
    required this.binanceWebSocketService,
  });

  final BinanceRestService binanceRestService;
  final BinanceWebSocketService binanceWebSocketService;
  
  final _marketDataController = StreamController<List<MarketData>>.broadcast();
  List<MarketData> _currentMarketData = [];
  final Map<String, MarketData> _marketDataMap = {};
  List<String>? _subscribedSymbols;
  Timer? _pollingTimer;
  StreamSubscription<TokenTicker>? _tickerSubscription;

  @override
  Stream<List<MarketData>> get marketDataStream => _marketDataController.stream;

  @override
  List<MarketData> get currentMarketData => List.unmodifiable(_currentMarketData);

  @override
  Future<List<MarketData>> getMarketData(List<String> symbols) async {
    try {
      // Convert symbols to Binance format (add USDT suffix if not present)
      final binanceSymbols = symbols.map((s) {
        if (s.toUpperCase().endsWith('USDT')) {
          return s.toUpperCase();
        }
        return '${s.toUpperCase()}USDT';
      }).toList();

      // Create JSON array string for the API
      final symbolsJson = '[${binanceSymbols.map((s) => '"$s"').join(',')}]';
      
      // Fetch ticker data from Binance
      final tickers = await binanceRestService.getTicker24hr(symbols: symbolsJson);
      
      // Convert to MarketData DTOs
      final marketData = tickers.map((ticker) {
        final price = double.parse(ticker.lastPrice);
        final changePercent = double.parse(ticker.priceChangePercent);
        final high = double.parse(ticker.highPrice);
        final low = double.parse(ticker.lowPrice);
        final volume = double.parse(ticker.volume);
        
        // Calculate 24h change from percentage
        final change24h = price * (changePercent / 100) / (1 + changePercent / 100);
        
        return MarketData(
          symbol: ticker.symbol.replaceAll('USDT', ''),
          price: price,
          change24h: change24h,
          changePercent24h: changePercent,
          high24h: high,
          low24h: low,
          volume24h: volume * price, // Volume in USD
          lastUpdated: DateTime.now(),
        );
      }).toList();

      // Update current data and map
      _currentMarketData = marketData;
      _marketDataMap.clear();
      for (final data in marketData) {
        _marketDataMap[data.symbol] = data;
      }
      _marketDataController.add(marketData);

      return marketData;
    } catch (e) {
      throw Exception('Failed to fetch market data: $e');
    }
  }

  @override
  Future<List<MarketData>> getTrendingTokens({int limit = 10}) async {
    // For MVP, return top cryptocurrencies by market cap
    final topSymbols = [
      'BTC', 'ETH', 'BNB', 'SOL', 'XRP',
      'ADA', 'AVAX', 'DOGE', 'DOT', 'MATIC',
    ].take(limit).toList();
    
    return getMarketData(topSymbols);
  }

  @override
  Future<void> subscribeToMarketUpdates(List<String> symbols) async {
    // Unsubscribe from previous symbols if any
    await unsubscribeFromMarketUpdates();

    _subscribedSymbols = symbols;
    
    // Fetch initial data via REST
    await getMarketData(symbols);
    
    // Convert symbols to Binance format for WebSocket
    final binanceSymbols = symbols.map((s) {
      if (s.toUpperCase().endsWith('USDT')) {
        return s.toLowerCase();
      }
      return '${s.toLowerCase()}usdt';
    }).toList();
    
    // Subscribe to WebSocket for real-time updates
    binanceWebSocketService.subscribeToSymbols(binanceSymbols);
    
    // Listen to ticker stream
    _tickerSubscription = binanceWebSocketService.tickerStream.listen(_handleTickerUpdate);
  }
  
  void _handleTickerUpdate(TokenTicker ticker) {
    // Extract base symbol (remove USDT suffix)
    final symbol = ticker.symbol.toUpperCase().replaceAll('USDT', '');
    
    // Check if this symbol is in our subscription list
    if (_subscribedSymbols?.contains(symbol) ?? false) {
      // Parse ticker data
      final price = double.parse(ticker.price);
      final changePercent = double.parse(ticker.changePercent);
      final high = double.parse(ticker.high);
      final low = double.parse(ticker.low);
      final volume = double.parse(ticker.volume);
      
      // Calculate 24h change from percentage
      final change24h = price * (changePercent / 100) / (1 + changePercent / 100);
      
      // Create updated market data
      final updatedData = MarketData(
        symbol: symbol,
        price: price,
        change24h: change24h,
        changePercent24h: changePercent,
        high24h: high,
        low24h: low,
        volume24h: volume * price, // Volume in USD
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(ticker.eventTime),
      );
      
      // Update the map
      _marketDataMap[symbol] = updatedData;
      
      // Rebuild the list maintaining the original order
      _currentMarketData = _subscribedSymbols!
          .where(_marketDataMap.containsKey)
          .map((s) => _marketDataMap[s]!)
          .toList();
      
      // Emit updated data
      _marketDataController.add(_currentMarketData);
    }
  }

  @override
  Future<void> unsubscribeFromMarketUpdates() async {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    
    // Cancel WebSocket subscription
    await _tickerSubscription?.cancel();
    _tickerSubscription = null;
    
    // Unsubscribe from WebSocket symbols
    if (_subscribedSymbols != null) {
      final binanceSymbols = _subscribedSymbols!.map((s) {
        if (s.toUpperCase().endsWith('USDT')) {
          return s.toLowerCase();
        }
        return '${s.toLowerCase()}usdt';
      }).toList();
      binanceWebSocketService.unsubscribeFromSymbols(binanceSymbols);
    }
    
    _subscribedSymbols = null;
  }

  @override
  void clearCache() {
    _currentMarketData = [];
    _marketDataController.add([]);
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _tickerSubscription?.cancel();
    _marketDataController.close();
    unsubscribeFromMarketUpdates();
  }
}
