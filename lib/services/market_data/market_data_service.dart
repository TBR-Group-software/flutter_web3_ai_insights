import 'dart:async';
import 'package:web3_ai_assistant/services/market_data/models/token_price.dart';

abstract class MarketDataService {
  Stream<TokenPrice> get priceStream;
  Map<String, TokenPrice> get cachedPrices;

  Future<TokenPrice?> getTokenPrice(String symbol);
  Future<List<TokenPrice>> getTokenPrices(List<String> symbols);
  
  void subscribeToPrice(String symbol);
  void unsubscribeFromPrice(String symbol);
  void subscribeToMultiplePrices(List<String> symbols);
  void unsubscribeFromMultiplePrices(List<String> symbols);
  
  void dispose();
} 
