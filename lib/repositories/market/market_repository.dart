import 'dart:async';
import 'package:web3_ai_assistant/repositories/market/models/market_data.dart';

abstract class MarketRepository {
  /// Stream of market data for real-time updates
  Stream<List<MarketData>> get marketDataStream;
  
  /// Current market data
  List<MarketData> get currentMarketData;
  
  /// Fetch market data for specific symbols
  Future<List<MarketData>> getMarketData(List<String> symbols);
  
  /// Fetch trending cryptocurrencies
  Future<List<MarketData>> getTrendingTokens({int limit = 10});
  
  /// Subscribe to real-time market updates
  Future<void> subscribeToMarketUpdates(List<String> symbols);
  
  /// Unsubscribe from market updates
  Future<void> unsubscribeFromMarketUpdates();
  
  /// Clear market data cache
  void clearCache();
  
  /// Dispose of resources
  void dispose();
}
