import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:web3_ai_assistant/services/market_data/market_data_service.dart';
import 'package:web3_ai_assistant/services/market_data/models/token_price.dart';
import 'package:web3_ai_assistant/services/market_data/binance_api.dart';
import 'package:web3_ai_assistant/services/market_data/binance_websocket_service.dart';

/// Implementation of MarketDataService using Binance API
/// Follows clean architecture with separated REST API and WebSocket concerns
class BinanceService implements MarketDataService {
  BinanceService({
    BinanceApi? api,
    BinanceWebSocketService? webSocketService,
    Logger? logger,
  }) : _api = api ?? BinanceApi(
         Dio(BaseOptions(
           connectTimeout: const Duration(seconds: 10),
           receiveTimeout: const Duration(seconds: 30),
         )),
               ),
       _webSocketService = webSocketService ?? BinanceWebSocketService(
         logger: logger,
       ),
       _logger = logger ?? Logger();

  final BinanceApi _api;
  final BinanceWebSocketService _webSocketService;
  final Logger _logger;
  
  static const int _maxRequestsPerSecond = 20;
  
  // Caching and rate limiting
  final Map<String, TokenPrice> _priceCache = {};
  final Map<String, DateTime> _lastRequestTime = {};

  @override
  Stream<TokenPrice> get priceStream => _webSocketService.priceStream.map((price) {
    // Update cache with real-time data
    _priceCache[price.symbol] = price;
    return price;
  });

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
    _webSocketService.subscribeToPrice(symbol);
  }

  @override
  void unsubscribeFromPrice(String symbol) {
    _webSocketService.unsubscribeFromPrice(symbol);
  }

  @override
  void subscribeToMultiplePrices(List<String> symbols) {
    _webSocketService.subscribeToMultiplePrices(symbols);
  }

  @override
  void unsubscribeFromMultiplePrices(List<String> symbols) {
    _webSocketService.unsubscribeFromMultiplePrices(symbols);
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



  @override
  void dispose() {
    _webSocketService.dispose();
    _priceCache.clear();
    _lastRequestTime.clear();
  }
}
