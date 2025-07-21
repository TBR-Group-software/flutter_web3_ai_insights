import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web3_ai_assistant/services/market_data/market_data_service.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_price.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_ticker.dart';
import 'package:web3_ai_assistant/services/market_data/models/ticker_24hr.dart';
import 'package:web3_ai_assistant/services/market_data/models/simple_price.dart';

part 'binance_service.g.dart';

@RestApi()
/// Service for retrieving market data from Binance API with REST API and Retrofit
abstract class BinanceApi {
  factory BinanceApi(Dio dio, {String baseUrl}) = _BinanceApi;

  /// Get latest prices for symbols
  @GET('/api/v3/ticker/price')
  Future<List<SimplePrice>> getPrices({
    @Query('symbols') required String symbols,
  });

  /// Get 24hr ticker statistics for symbols
  @GET('/api/v3/ticker/24hr')
  Future<List<Ticker24hr>> getTicker24hr({
    @Query('symbols') required String symbols,
  });
}

class BinanceService implements MarketDataService {

  BinanceService({
    BinanceApi? api,
    Logger? logger,
  }) : _api = api ?? BinanceApi(
         Dio(BaseOptions(connectTimeout: const Duration(seconds: 10))),
         baseUrl: 'https://api.binance.com',
       ),
        _logger = logger ?? Logger();
  final BinanceApi _api;
  final Logger _logger;
  
  static const String _wsUrl = 'wss://stream.binance.com:9443/ws/stream';
  static const int _maxRequestsPerSecond = 20;
  
  // WebSocket related fields
  IOWebSocketChannel? _webSocketChannel;
  bool _isConnected = false;
  bool _isReconnecting = false;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  final Set<String> _subscribedSymbols = {};
  
  // Caching and rate limiting
  final Map<String, TokenPrice> _priceCache = {};
  final Map<String, DateTime> _lastRequestTime = {};
  StreamController<TokenPrice>? _priceController;

  @override
  Stream<TokenPrice> get priceStream => 
      _priceController?.stream ?? const Stream.empty();

  @override
  Map<String, TokenPrice> get cachedPrices => Map.unmodifiable(_priceCache);

  @override
  Future<TokenPrice?> getTokenPrice(String symbol) async {
    // Check cache first
    if (_priceCache.containsKey(symbol)) {
      final cachedPrice = _priceCache[symbol]!;
      if (DateTime.now().difference(cachedPrice.lastUpdated).inMinutes < 5) {
        return cachedPrice;
      }
    }

    try {
      await _rateLimitCheck('single_price');
      final response = await _api.getPrices(symbols: '["$symbol"]');
      
      if (response.isNotEmpty) {
        final data = response.first;
        final price = TokenPrice(
          symbol: data.symbol,
          price: double.parse(data.price),
          change24h: 0, // Single price endpoint doesn't provide change
          changePercent24h: 0,
          high24h: 0,
          low24h: 0,
          volume24h: 0,
          lastUpdated: DateTime.now(),
        );
        _priceCache[symbol] = price;
        return price;
      }
    } catch (e) {
      _logger.e('Error fetching price for $symbol: $e');
    }
    return null;
  }

  @override
  Future<List<TokenPrice>> getTokenPrices(List<String> symbols) async {
    if (symbols.isEmpty) {
      return [];
    }
    
    try {
      await _rateLimitCheck('batch_prices');
      final symbolsJson = jsonEncode(symbols);
      final response = await _api.getTicker24hr(symbols: symbolsJson);
      
      final prices = <TokenPrice>[];
      for (final item in response) {
        final price = TokenPrice(
          symbol: item.symbol,
          price: double.parse(item.lastPrice),
          change24h: double.parse(item.lastPrice) * (double.parse(item.priceChangePercent) / 100),
          changePercent24h: double.parse(item.priceChangePercent),
          high24h: double.parse(item.highPrice),
          low24h: double.parse(item.lowPrice),
          volume24h: double.parse(item.volume),
          lastUpdated: DateTime.fromMillisecondsSinceEpoch(item.closeTime),
        );
        prices.add(price);
        _priceCache[item.symbol] = price;
      }
      
      return prices;
    } catch (e) {
      _logger.e('Error fetching batch prices: $e');
      return [];
    }
  }


  @override
  void subscribeToPrice(String symbol) {
    subscribeToMultiplePrices([symbol]);
  }

  @override
  void unsubscribeFromPrice(String symbol) {
    unsubscribeFromMultiplePrices([symbol]);
  }

  @override
  void subscribeToMultiplePrices(List<String> symbols) {
    for (final symbol in symbols) {
      _subscribedSymbols.add(symbol.toLowerCase());
    }
    _connectWebSocket();
  }

  @override
  void unsubscribeFromMultiplePrices(List<String> symbols) {
    for (final symbol in symbols) {
      _subscribedSymbols.remove(symbol.toLowerCase());
    }
    
    if (_subscribedSymbols.isEmpty) {
      _disconnectWebSocket();
    } else {
      _connectWebSocket(); // Reconnect with updated subscriptions
    }
  }

  Future<void> _rateLimitCheck(String key) async {
    final now = DateTime.now();
    final lastRequest = _lastRequestTime[key];
    
    if (lastRequest != null) {
      final timeSinceLastRequest = now.difference(lastRequest).inMilliseconds;
      final minInterval = (1000 / _maxRequestsPerSecond).ceil();
      
      if (timeSinceLastRequest < minInterval) {
        await Future.delayed(Duration(milliseconds: minInterval - timeSinceLastRequest));
      }
    }
    
    _lastRequestTime[key] = now;
  }

  void _connectWebSocket() {
    if (_isConnected || _isReconnecting || _subscribedSymbols.isEmpty) {
      return;
    }
    
    _isReconnecting = true;
    _disconnectWebSocket();
    
    try {
      _priceController ??= StreamController<TokenPrice>.broadcast();
      
      final streams = _subscribedSymbols.map((symbol) => '$symbol@ticker').join('/');
      final wsUrl = '$_wsUrl/$streams';
      
      _webSocketChannel = IOWebSocketChannel.connect(wsUrl);
      _isConnected = true;
      _isReconnecting = false;
      
      _logger.i('WebSocket connected to Binance for symbols: ${_subscribedSymbols.join(', ')}');
      
      _webSocketChannel!.stream.listen(
        (message) => _handleWebSocketMessage(message as String),
        onError: _handleWebSocketError,
        onDone: _handleWebSocketDone,
      );
      
      _startHeartbeat();
    } catch (e) {
      _logger.e('WebSocket connection failed: $e');
      _isConnected = false;
      _isReconnecting = false;
      _scheduleReconnect();
    }
  }

  void _handleWebSocketMessage(String message) {
    try {
      final data = jsonDecode(message);
      
      if (data is Map<String, dynamic>) {
        final ticker = TokenTicker.fromJson(data);
        final currentPrice = double.parse(ticker.price);
        final changePercent = double.parse(ticker.changePercent);
        
        final price = TokenPrice(
          symbol: ticker.symbol,
          price: currentPrice,
          change24h: currentPrice * (changePercent / 100),
          changePercent24h: changePercent,
          high24h: double.parse(ticker.high),
          low24h: double.parse(ticker.low),
          volume24h: double.parse(ticker.volume),
          lastUpdated: DateTime.fromMillisecondsSinceEpoch(ticker.eventTime),
        );
        
        _priceCache[ticker.symbol] = price;
        _priceController?.add(price);
      }
    } catch (e) {
      _logger.e('Error parsing WebSocket message: $e');
    }
  }

  void _handleWebSocketError(Object error) {
    _logger.e('WebSocket error: $error');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _handleWebSocketDone() {
    _logger.i('WebSocket connection closed');
    _isConnected = false;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_isReconnecting || _subscribedSymbols.isEmpty) {
      return;
    }
    
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      Duration(seconds: 5 + Random().nextInt(10)), // Random backoff
      _connectWebSocket,
    );
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (timer) {
        if (_isConnected) {
          try {
            _webSocketChannel?.sink.add(jsonEncode({'method': 'ping'}));
          } catch (e) {
            _logger.e('Heartbeat failed: $e');
            _isConnected = false;
            _scheduleReconnect();
          }
        }
      },
    );
  }

  void _disconnectWebSocket() {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _webSocketChannel?.sink.close();
    _webSocketChannel = null;
    _isConnected = false;
    _isReconnecting = false;
  }

  @override
  void dispose() {
    _disconnectWebSocket();
    _priceController?.close();
    _priceController = null;
    _priceCache.clear();
    _lastRequestTime.clear();
    _subscribedSymbols.clear();
  }
} 
