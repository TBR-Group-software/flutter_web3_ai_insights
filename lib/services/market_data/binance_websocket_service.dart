import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_price.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_ticker.dart';

/// WebSocket service for real-time Binance price streaming
class BinanceWebSocketService {
  BinanceWebSocketService({
    Logger? logger,
  }) : _logger = logger ?? Logger();

  final Logger _logger;
  
  static const String _wsUrl = 'wss://stream.binance.com:9443/ws/stream';
  
  // WebSocket related fields
  WebSocketChannel? _webSocketChannel;
  bool _isConnected = false;
  bool _isReconnecting = false;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  final Set<String> _subscribedSymbols = {};
  
  StreamController<TokenPrice>? _priceController;

  /// Stream of real-time price updates
  Stream<TokenPrice> get priceStream => 
      _priceController?.stream ?? const Stream.empty();

  /// Current subscribed symbols
  Set<String> get subscribedSymbols => Set.unmodifiable(_subscribedSymbols);

  /// Check if WebSocket is connected
  bool get isConnected => _isConnected;

  /// Subscribe to price updates for multiple symbols
  void subscribeToMultiplePrices(List<String> symbols) {
    if (symbols.isEmpty) {
      _logger.w('No symbols provided for WebSocket subscription');
      return;
    }
    
    _logger.i('📡 Subscribing to WebSocket price updates for: $symbols');
    for (final symbol in symbols) {
      _subscribedSymbols.add(symbol.toLowerCase());
    }
    
    _connectWebSocket();
  }

  /// Unsubscribe from price updates for multiple symbols
  void unsubscribeFromMultiplePrices(List<String> symbols) {
    if (symbols.isEmpty) {
      return;
    }
    
    for (final symbol in symbols) {
      _subscribedSymbols.remove(symbol.toLowerCase());
    }
    
    if (_subscribedSymbols.isEmpty) {
      _disconnectWebSocket();
    } else {
      _connectWebSocket(); // Reconnect with updated subscriptions
    }
  }

  /// Subscribe to price updates for a single symbol
  void subscribeToPrice(String symbol) {
    subscribeToMultiplePrices([symbol]);
  }

  /// Unsubscribe from price updates for a single symbol
  void unsubscribeFromPrice(String symbol) {
    unsubscribeFromMultiplePrices([symbol]);
  }

  void _connectWebSocket() {
    if (_isConnected || _isReconnecting || _subscribedSymbols.isEmpty) {
      _logger.d('Skipping WebSocket connection: connected=$_isConnected, reconnecting=$_isReconnecting, symbols=${_subscribedSymbols.length}');
      return;
    }
    
    _isReconnecting = true;
    _disconnectWebSocket();
    
    try {
      _priceController ??= StreamController<TokenPrice>.broadcast();
      
      final streams = _subscribedSymbols.map((symbol) => '$symbol@ticker').join('/');
      final wsUrl = '$_wsUrl/$streams';
      
      _logger.i('Connecting WebSocket to: $wsUrl');
      _webSocketChannel = WebSocketChannel.connect(Uri.parse(wsUrl));
      _isConnected = true;
      _isReconnecting = false;
      
      _logger.i('✅ WebSocket connected to Binance for symbols: ${_subscribedSymbols.join(', ')}');
      
      _webSocketChannel!.stream.listen(
        (message) => _handleWebSocketMessage(message as String),
        onError: _handleWebSocketError,
        onDone: _handleWebSocketDone,
      );
      
      _startHeartbeat();
    } catch (e) {
      _logger.e('❌ WebSocket connection failed: $e');
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
        
        _logger.d('🔄 Real-time price update: ${price.symbol} = \$${price.price}');
        _priceController?.add(price);
      }
    } catch (e) {
      _logger.e('Error parsing WebSocket message: $e');
      _logger.e('Raw message: $message');
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

  /// Dispose the service and clean up resources
  void dispose() {
    _disconnectWebSocket();
    _priceController?.close();
    _priceController = null;
    _subscribedSymbols.clear();
  }
} 
