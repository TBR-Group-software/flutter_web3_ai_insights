import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// The application name
  ///
  /// In en, this message translates to:
  /// **'Web3 AI Insights'**
  String get appName;

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Web3 AI Assistant'**
  String get appTitle;

  /// Dashboard navigation label
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navigationDashboard;

  /// Wallet navigation label
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navigationWallet;

  /// Portfolio navigation label
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get navigationPortfolio;

  /// AI Insights navigation label
  ///
  /// In en, this message translates to:
  /// **'AI Insights'**
  String get navigationAiInsights;

  /// Connect wallet button text
  ///
  /// In en, this message translates to:
  /// **'Connect MetaMask'**
  String get walletConnect;

  /// Wallet connecting state
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get walletConnecting;

  /// Disconnect wallet button text
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get walletDisconnect;

  /// Disconnect wallet confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Disconnect Wallet'**
  String get walletDisconnectConfirmTitle;

  /// Disconnect wallet confirmation dialog message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect your wallet? You can reconnect at any time.'**
  String get walletDisconnectConfirmMessage;

  /// Wallet loading state
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get walletLoading;

  /// Retry wallet connection button text
  ///
  /// In en, this message translates to:
  /// **'Retry Connection'**
  String get walletRetryConnection;

  /// Wallet error label
  ///
  /// In en, this message translates to:
  /// **'Wallet Error'**
  String get walletError;

  /// Wallet connected status
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get walletConnected;

  /// No wallet connected message
  ///
  /// In en, this message translates to:
  /// **'No wallet connected'**
  String get walletNoConnection;

  /// Connect wallet to view message
  ///
  /// In en, this message translates to:
  /// **'Connect your wallet to view portfolio'**
  String get walletConnectToView;

  /// Address copied to clipboard message
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get walletAddressCopied;

  /// Wallet address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get walletAddress;

  /// Wallet balance label
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get walletBalance;

  /// Wallet network label
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get walletNetwork;

  /// View wallet action
  ///
  /// In en, this message translates to:
  /// **'View Wallet'**
  String get walletViewWallet;

  /// Copy address action
  ///
  /// In en, this message translates to:
  /// **'Copy Address'**
  String get walletCopyAddress;

  /// Portfolio summary header
  ///
  /// In en, this message translates to:
  /// **'Portfolio Summary'**
  String get portfolioSummary;

  /// Portfolio value label
  ///
  /// In en, this message translates to:
  /// **'Portfolio Value'**
  String get portfolioValue;

  /// Total value label
  ///
  /// In en, this message translates to:
  /// **'Total Value'**
  String get portfolioTotalValue;

  /// 24 hour change label
  ///
  /// In en, this message translates to:
  /// **'24h Change'**
  String get portfolio24hChange;

  /// Tokens count label
  ///
  /// In en, this message translates to:
  /// **'Tokens'**
  String get portfolioTokens;

  /// Top performer label
  ///
  /// In en, this message translates to:
  /// **'Top Performer: '**
  String get portfolioTopPerformer;

  /// No tokens found title
  ///
  /// In en, this message translates to:
  /// **'No Tokens Found'**
  String get portfolioNoTokens;

  /// No tokens found description
  ///
  /// In en, this message translates to:
  /// **'Your wallet doesn\'t contain any supported tokens yet'**
  String get portfolioNoTokensDescription;

  /// Holdings label
  ///
  /// In en, this message translates to:
  /// **'Holdings'**
  String get portfolioHoldings;

  /// Error loading portfolio
  ///
  /// In en, this message translates to:
  /// **'Error loading portfolio'**
  String get portfolioErrorLoading;

  /// Connect wallet message for portfolio
  ///
  /// In en, this message translates to:
  /// **'Connect wallet to view transactions'**
  String get portfolioConnectWallet;

  /// Recent transactions header
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get transactionsRecent;

  /// No recent transactions message
  ///
  /// In en, this message translates to:
  /// **'No recent transactions'**
  String get transactionsNone;

  /// Error loading transactions
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions'**
  String get transactionsErrorLoading;

  /// Connect wallet to view transactions
  ///
  /// In en, this message translates to:
  /// **'Connect wallet to view transactions'**
  String get transactionsConnectWallet;

  /// Generate AI report button
  ///
  /// In en, this message translates to:
  /// **'Generate AI Report'**
  String get aiGenerateReport;

  /// Generating report state
  ///
  /// In en, this message translates to:
  /// **'Generating Report...'**
  String get aiGeneratingReport;

  /// Generate new report button
  ///
  /// In en, this message translates to:
  /// **'Generate New Report'**
  String get aiGenerateNewReport;

  /// Generate full report button
  ///
  /// In en, this message translates to:
  /// **'Generate Full Report'**
  String get aiGenerateFullReport;

  /// AI analysis requirements
  ///
  /// In en, this message translates to:
  /// **'To generate AI insights, you need:'**
  String get aiRequirements;

  /// First requirement
  ///
  /// In en, this message translates to:
  /// **'1. Connected wallet'**
  String get aiRequirement1;

  /// Second requirement
  ///
  /// In en, this message translates to:
  /// **'2. Token holdings data'**
  String get aiRequirement2;

  /// AI insights feature description
  ///
  /// In en, this message translates to:
  /// **'Get AI-powered insights for your Web3 portfolio'**
  String get aiDescription;

  /// AI processing time message
  ///
  /// In en, this message translates to:
  /// **'This may take a few moments'**
  String get aiProcessingTime;

  /// AI analysis overview section
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get aiOverview;

  /// AI performance summary section
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get aiPerformanceSummary;

  /// Concentration risks section
  ///
  /// In en, this message translates to:
  /// **'Concentration Risks'**
  String get aiConcentrationRisks;

  /// Volatility risks section
  ///
  /// In en, this message translates to:
  /// **'Volatility Risks'**
  String get aiVolatilityRisks;

  /// Mitigation strategies section
  ///
  /// In en, this message translates to:
  /// **'Mitigation Strategies'**
  String get aiMitigationStrategies;

  /// Continue monitoring recommendation
  ///
  /// In en, this message translates to:
  /// **'Continue Monitoring'**
  String get aiContinueMonitoring;

  /// Market analysis section
  ///
  /// In en, this message translates to:
  /// **'Market Analysis'**
  String get aiMarketAnalysis;

  /// Low risk level
  ///
  /// In en, this message translates to:
  /// **'LOW RISK'**
  String get riskLow;

  /// Medium risk level
  ///
  /// In en, this message translates to:
  /// **'MEDIUM RISK'**
  String get riskMedium;

  /// High risk level
  ///
  /// In en, this message translates to:
  /// **'HIGH RISK'**
  String get riskHigh;

  /// Low priority
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get priorityLow;

  /// Medium priority
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get priorityMedium;

  /// High priority
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get priorityHigh;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWrong;

  /// Error loading wallet state
  ///
  /// In en, this message translates to:
  /// **'Error loading wallet state'**
  String get errorLoadingWalletState;

  /// Try again button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Go to dashboard button
  ///
  /// In en, this message translates to:
  /// **'Go to Dashboard'**
  String get goToDashboard;

  /// Percentage change format with sign
  ///
  /// In en, this message translates to:
  /// **'{value}% (24h)'**
  String percentageChange(String value);

  /// Currency value format
  ///
  /// In en, this message translates to:
  /// **'\${value}'**
  String currencyValue(String value);

  /// Token balance format
  ///
  /// In en, this message translates to:
  /// **'{amount} {symbol}'**
  String tokenBalance(String amount, String symbol);

  /// Risk score format
  ///
  /// In en, this message translates to:
  /// **'{score}/100'**
  String riskScore(int score);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
