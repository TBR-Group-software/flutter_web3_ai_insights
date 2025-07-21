import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/providers/repository_providers.dart';

part 'portfolio_providers.g.dart';

@riverpod
class PortfolioNotifier extends _$PortfolioNotifier {
  @override
  Future<List<PortfolioToken>> build() async {
    final walletRepository = ref.watch(walletRepositoryProvider);
    final portfolioRepository = ref.watch(portfolioRepositoryProvider);

    // Listen to wallet state changes
    walletRepository.walletStateStream.listen((walletState) {
      if (walletState.isConnected) {
        ref.invalidateSelf();
      }
    });

    // Get current wallet state
    final currentWalletState = walletRepository.currentWalletState;
    if (currentWalletState.isConnected && currentWalletState.walletInfo != null) {
      return portfolioRepository.getPortfolio(currentWalletState.walletInfo!.address);
    }

    return [];
  }

  Future<void> refreshPortfolio() async {
    final walletRepository = ref.watch(walletRepositoryProvider);
    final portfolioRepository = ref.watch(portfolioRepositoryProvider);

    final currentWalletState = walletRepository.currentWalletState;
    if (currentWalletState.isConnected && currentWalletState.walletInfo != null) {
      await portfolioRepository.refreshPortfolio(currentWalletState.walletInfo!.address);
      ref.invalidateSelf();
    }
  }

  Future<void> subscribeToUpdates() async {
    final walletRepository = ref.watch(walletRepositoryProvider);
    final portfolioRepository = ref.watch(portfolioRepositoryProvider);

    final currentWalletState = walletRepository.currentWalletState;
    if (currentWalletState.isConnected && currentWalletState.walletInfo != null) {
      await portfolioRepository.subscribeToPortfolioUpdates(currentWalletState.walletInfo!.address);
    }
  }

  Future<void> unsubscribeFromUpdates() async {
    final portfolioRepository = ref.watch(portfolioRepositoryProvider);
    await portfolioRepository.unsubscribeFromPortfolioUpdates();
  }
}

@riverpod
Stream<List<PortfolioToken>> portfolioStream(PortfolioStreamRef ref) {
  final portfolioRepository = ref.watch(portfolioRepositoryProvider);
  return portfolioRepository.portfolioStream;
}

@riverpod
bool isPortfolioEmpty(IsPortfolioEmptyRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  return portfolioAsync.maybeWhen(data: (tokens) => tokens.isEmpty, orElse: () => true);
}

@riverpod
double totalPortfolioValue(TotalPortfolioValueRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  return portfolioAsync.maybeWhen(
    data: (tokens) => tokens.fold(0.0, (sum, token) => sum + token.totalValue),
    orElse: () => 0.0,
  );
}

@riverpod
double totalPortfolioChange(TotalPortfolioChangeRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  return portfolioAsync.maybeWhen(
    data: (tokens) => tokens.fold(0.0, (sum, token) => sum + token.change24h),
    orElse: () => 0.0,
  );
}

@riverpod
double totalPortfolioChangePercent(TotalPortfolioChangePercentRef ref) {
  final totalValue = ref.watch(totalPortfolioValueProvider);
  final totalChange = ref.watch(totalPortfolioChangeProvider);
  return totalValue > 0 ? (totalChange / totalValue) * 100 : 0.0;
}

@riverpod
List<PortfolioToken> topPerformingTokens(TopPerformingTokensRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  return portfolioAsync.maybeWhen(
    data: (tokens) {
      final sorted = List<PortfolioToken>.from(tokens)
        ..sort((a, b) => b.changePercent24h.compareTo(a.changePercent24h));
      return sorted.take(5).toList();
    },
    orElse: () => [],
  );
}

@riverpod
List<PortfolioToken> topValueTokens(TopValueTokensRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  return portfolioAsync.maybeWhen(
    data: (tokens) {
      final sorted = List<PortfolioToken>.from(tokens)..sort((a, b) => b.totalValue.compareTo(a.totalValue));
      return sorted.take(10).toList();
    },
    orElse: () => [],
  );
}
