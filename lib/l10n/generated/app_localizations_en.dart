// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Web3 AI Insights';

  @override
  String get appTitle => 'Web3 AI Assistant';

  @override
  String get navigationDashboard => 'Dashboard';

  @override
  String get navigationWallet => 'Wallet';

  @override
  String get navigationPortfolio => 'Portfolio';

  @override
  String get navigationAiInsights => 'AI Insights';

  @override
  String get walletConnect => 'Connect MetaMask';

  @override
  String get walletConnecting => 'Connecting...';

  @override
  String get walletDisconnect => 'Disconnect';

  @override
  String get walletDisconnectConfirmTitle => 'Disconnect Wallet';

  @override
  String get walletDisconnectConfirmMessage => 'Are you sure you want to disconnect your wallet? You can reconnect at any time.';

  @override
  String get walletLoading => 'Loading...';

  @override
  String get walletRetryConnection => 'Retry Connection';

  @override
  String get walletError => 'Wallet Error';

  @override
  String get walletConnected => 'Connected';

  @override
  String get walletNoConnection => 'No wallet connected';

  @override
  String get walletConnectToView => 'Connect your wallet to view portfolio';

  @override
  String get walletAddressCopied => 'Address copied to clipboard';

  @override
  String get walletAddress => 'Address';

  @override
  String get walletBalance => 'Balance';

  @override
  String get walletNetwork => 'Network';

  @override
  String get walletViewWallet => 'View Wallet';

  @override
  String get walletCopyAddress => 'Copy Address';

  @override
  String get portfolioSummary => 'Portfolio Summary';

  @override
  String get portfolioValue => 'Portfolio Value';

  @override
  String get portfolioTotalValue => 'Total Value';

  @override
  String get portfolio24hChange => '24h Change';

  @override
  String get portfolioTokens => 'Tokens';

  @override
  String get portfolioTopPerformer => 'Top Performer: ';

  @override
  String get portfolioNoTokens => 'No Tokens Found';

  @override
  String get portfolioNoTokensDescription => 'Your wallet doesn\'t contain any supported tokens yet';

  @override
  String get portfolioHoldings => 'Holdings';

  @override
  String get portfolioErrorLoading => 'Error loading portfolio';

  @override
  String get portfolioConnectWallet => 'Connect wallet to view transactions';

  @override
  String get transactionsRecent => 'Recent Transactions';

  @override
  String get transactionsNone => 'No recent transactions';

  @override
  String get transactionsErrorLoading => 'Error loading transactions';

  @override
  String get transactionsConnectWallet => 'Connect wallet to view transactions';

  @override
  String get aiGenerateReport => 'Generate AI Report';

  @override
  String get aiGeneratingReport => 'Generating Report...';

  @override
  String get aiGenerateNewReport => 'Generate New Report';

  @override
  String get aiGenerateFullReport => 'Generate Full Report';

  @override
  String get aiRequirements => 'To generate AI insights, you need:';

  @override
  String get aiRequirement1 => '1. Connected wallet';

  @override
  String get aiRequirement2 => '2. Token holdings data';

  @override
  String get aiDescription => 'Get AI-powered insights for your Web3 portfolio';

  @override
  String get aiProcessingTime => 'This may take a few moments';

  @override
  String get aiOverview => 'Overview';

  @override
  String get aiPerformanceSummary => 'Performance Summary';

  @override
  String get aiConcentrationRisks => 'Concentration Risks';

  @override
  String get aiVolatilityRisks => 'Volatility Risks';

  @override
  String get aiMitigationStrategies => 'Mitigation Strategies';

  @override
  String get aiContinueMonitoring => 'Continue Monitoring';

  @override
  String get aiMarketAnalysis => 'Market Analysis';

  @override
  String get riskLow => 'LOW RISK';

  @override
  String get riskMedium => 'MEDIUM RISK';

  @override
  String get riskHigh => 'HIGH RISK';

  @override
  String get priorityLow => 'LOW';

  @override
  String get priorityMedium => 'MEDIUM';

  @override
  String get priorityHigh => 'HIGH';

  @override
  String get errorSomethingWrong => 'Something went wrong';

  @override
  String get errorLoadingWalletState => 'Error loading wallet state';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get close => 'Close';

  @override
  String get cancel => 'Cancel';

  @override
  String get goToDashboard => 'Go to Dashboard';

  @override
  String percentageChange(String value) {
    return '$value% (24h)';
  }

  @override
  String currencyValue(String value) {
    return '\$$value';
  }

  @override
  String tokenBalance(String amount, String symbol) {
    return '$amount $symbol';
  }

  @override
  String riskScore(int score) {
    return '$score/100';
  }
}
