import 'package:web3_ai_assistant/services/binance_websocket/models/token_ticker.dart';

/// Abstract interface for Binance WebSocket service
abstract class BinanceWebSocketService {
  /// Stream of real-time ticker updates
  Stream<TokenTicker> get tickerStream;
  
  /// Current subscribed symbols
  Set<String> get subscribedSymbols;
  
  /// Check if WebSocket is connected
  bool get isConnected;
  
  /// Subscribe to price updates for multiple symbols
  void subscribeToSymbols(List<String> symbols);
  
  /// Unsubscribe from price updates for multiple symbols
  void unsubscribeFromSymbols(List<String> symbols);
  
  /// Dispose the service and clean up resources
  void dispose();
}
