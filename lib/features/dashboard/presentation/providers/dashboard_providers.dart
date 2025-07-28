import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/features/portfolio/providers/portfolio_providers.dart';
import 'package:web3_ai_assistant/core/providers/repository_providers.dart';
import 'package:web3_ai_assistant/repositories/market/models/market_data.dart';
import 'package:web3_ai_assistant/repositories/transaction/models/transaction.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

part 'dashboard_providers.g.dart';

/// Dashboard loading state provider
final dashboardLoadingProvider = StateProvider<bool>((ref) => false);

/// Selected navigation index provider
final selectedNavigationIndexProvider = StateProvider<int>((ref) => 0);


/// Dashboard portfolio value provider - uses real portfolio data
final dashboardPortfolioValueProvider = Provider<double>((ref) {
  return ref.watch(totalPortfolioValueProvider);
});

/// Dashboard portfolio change provider - uses real portfolio data
final dashboardPortfolioChangeProvider = Provider<double>((ref) {
  return ref.watch(totalPortfolioChangeProvider);
});

/// Dashboard portfolio change percent provider - uses real portfolio data
final dashboardPortfolioChangePercentProvider = Provider<double>((ref) {
  return ref.watch(totalPortfolioChangePercentProvider);
});

/// Market overview provider - fetches real market data
@riverpod
Future<List<MarketData>> marketOverview(MarketOverviewRef ref) async {
  final marketRepository = ref.watch(marketRepositoryProvider);
  
  try {
    // Fetch prices for major cryptocurrencies
    return await marketRepository.getMarketData(['BTC', 'ETH', 'BNB']);
  } catch (e) {
    // Return empty list on error
    return [];
  }
}

/// Market overview stream provider - provides real-time market data updates
@riverpod
Stream<List<MarketData>> marketOverviewStream(MarketOverviewStreamRef ref) async* {
  final marketRepository = ref.watch(marketRepositoryProvider);
  
  // Define the symbols we want to track
  const symbols = ['BTC', 'ETH', 'BNB'];
  
  // Subscribe to market updates (this will fetch initial data and setup WebSocket)
  await marketRepository.subscribeToMarketUpdates(symbols);
  
  // Clean up subscription when provider is disposed
  ref.onDispose(marketRepository.unsubscribeFromMarketUpdates);
  
  // Yield initial data
  yield marketRepository.currentMarketData;
  
  // Yield stream updates
  yield* marketRepository.marketDataStream;
}

/// Recent transactions provider - fetches real transaction data
@riverpod
Future<List<Transaction>> recentTransactions(RecentTransactionsRef ref) async {
  final transactionRepository = ref.watch(transactionRepositoryProvider);
  final walletState = ref.watch(walletNotifierProvider).valueOrNull;
  
  if (walletState == null || !walletState.isConnected || walletState.walletInfo == null) {
    return [];
  }
  
  try {
    return await transactionRepository.getRecentTransactions(
      walletState.walletInfo!.address,
      limit: 10,
    );
  } catch (e) {
    // Return empty list on error
    return [];
  }
}
