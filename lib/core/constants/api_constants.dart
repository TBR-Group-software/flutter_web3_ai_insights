/// Constants for API interactions and caching
class ApiConstants {
  ApiConstants._();

  // Cache Durations
  static const Duration portfolioCacheDuration = Duration(minutes: 5);
  static const Duration aiInsightsCacheDuration = Duration(minutes: 5);
  static const Duration marketDataPollingInterval = Duration(seconds: 30);

  // API Timeouts
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration websocketTimeout = Duration(seconds: 60);
  static const Duration reconnectDelay = Duration(seconds: 5);
  static const Duration heartbeatInterval = Duration(seconds: 30);

  // Retry Configuration
  static const int maxRetries = 3;
  static const int reconnectAttempts = 5;
  static const int randomBackoffMax = 10; // seconds

  // Gemini AI Configuration
  static const double aiTemperature = 0.7;
  static const double aiTopP = 0.95;
  static const int aiTopK = 40;
  static const int aiMaxOutputTokens = 2048;
  static const int aiQuickInsightMaxTokens = 200;
  static const double aiQuickInsightTemperature = 0.5;

  // Binance Symbol Mappings
  static const Map<String, String> binanceSymbolMap = {
    'ETH': 'ETHUSDT',
    'WETH': 'ETHUSDT',
    'BTC': 'BTCUSDT',
    'WBTC': 'BTCUSDT',
    'USDC': 'USDCUSDT',
    'BNB': 'BNBUSDT',
    'ADA': 'ADAUSDT',
    'DOT': 'DOTUSDT',
    'LINK': 'LINKUSDT',
    'UNI': 'UNIUSDT',
    'MATIC': 'MATICUSDT',
    'AVAX': 'AVAXUSDT',
    'SOL': 'SOLUSDT',
  };

  // Special Tokens
  static const String stablecoinUsdt = 'USDT';
  static const double stablecoinPrice = 1;
  static const double stablecoinChange = 0;

  // Parsing Limits
  static const int maxRecommendations = 5;
  static const int maxMarketInsights = 5;
  static const int maxTitleLength = 60;
}
