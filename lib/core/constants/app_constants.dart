/// App-wide constants for the Web3 AI Insights application
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // App information
  static const String appName = 'Web3 AI Insights';
  static const String appTitle = 'Web3 AI Assistant';

  // Route names
  static const String dashboardRoute = '/';
  static const String walletRoute = '/wallet';
  static const String portfolioRoute = '/portfolio';
  static const String aiInsightsRoute = '/ai-insights';

  // Route names for GoRouter
  static const String dashboardRouteName = 'dashboard';
  static const String walletRouteName = 'wallet';
  static const String portfolioRouteName = 'portfolio';
  static const String aiInsightsRouteName = 'ai-insights';

  // Navigation labels
  static const String dashboardLabel = 'Dashboard';
  static const String walletLabel = 'Wallet';
  static const String portfolioLabel = 'Portfolio';
  static const String aiInsightsLabel = 'AI Insights';

  // API Base URLs
  static const String binanceRestApiUrl = 'https://api.binance.com';
  static const String binanceWebSocketUrl = 'wss://stream.binance.com:9443/ws/stream';
  static const String geminiApiUrl = 'https://generativelanguage.googleapis.com';
}
