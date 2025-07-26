import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web3_ai_assistant/services/binance_websocket/binance_websocket_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/models/token_ticker.dart';

/// Implementation of BinanceWebSocketService for real-time price streaming
class BinanceWebSocketServiceImpl implements BinanceWebSocketService {
  BinanceWebSocketServiceImpl({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const String _wsUrl = 'wss://stream.binance.com:9443/ws/stream';

  // WebSocket related fields
  WebSocketChannel? _webSocketChannel;
  bool _isConnected = false;
  bool _isReconnecting = false;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  final Set<String> _subscribedSymbols = {};

  StreamController<TokenTicker>? _tickerController;

  @override
  Stream<TokenTicker> get tickerStream => _tickerController?.stream ?? const Stream.empty();

  @override
  Set<String> get subscribedSymbols => Set.unmodifiable(_subscribedSymbols);

  @override
  bool get isConnected => _isConnected;

  @override
  void subscribeToSymbols(List<String> symbols) {
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

  @override
  void unsubscribeFromSymbols(List<String> symbols) {
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

  void _connectWebSocket() {
    if (_isConnected || _isReconnecting || _subscribedSymbols.isEmpty) {
      _logger.d(
        'Skipping WebSocket connection: connected=$_isConnected, reconnecting=$_isReconnecting, symbols=${_subscribedSymbols.length}',
      );
      return;
    }

    _isReconnecting = true;
    _disconnectWebSocket();

    try {
      _tickerController ??= StreamController<TokenTicker>.broadcast();

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

        _logger.d('🔄 Real-time ticker update: ${ticker.symbol} = \$${ticker.price}');
        _tickerController?.add(ticker);
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
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_isConnected) {
        try {
          _webSocketChannel?.sink.add(jsonEncode({'method': 'ping'}));
        } catch (e) {
          _logger.e('Heartbeat failed: $e');
          _isConnected = false;
          _scheduleReconnect();
        }
      }
    });
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
    _tickerController?.close();
    _tickerController = null;
    _subscribedSymbols.clear();
  }
}
