import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/core/providers/repository_providers.dart';
import 'package:web3_ai_assistant/features/portfolio/providers/portfolio_providers.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

part 'ai_insights_providers.g.dart';

/// Base state for AI insights feature
sealed class AiInsightsState {
  const AiInsightsState();
}

/// Initial state before any analysis is generated
class AiInsightsInitial extends AiInsightsState {
  const AiInsightsInitial();
}

/// Loading state while AI analysis is being generated
class AiInsightsLoading extends AiInsightsState {
  const AiInsightsLoading();
}

/// State containing analysis history with navigation
class AiInsightsWithHistory extends AiInsightsState {
  const AiInsightsWithHistory({
    required this.history,
    required this.currentIndex,
  });
  
  final List<PortfolioAnalysis> history;
  final int currentIndex;
  
  PortfolioAnalysis? get currentAnalysis => 
    history.isNotEmpty && currentIndex >= 0 && currentIndex < history.length 
      ? history[currentIndex] 
      : null;
  
  bool get hasNext => currentIndex < history.length - 1;
  bool get hasPrevious => currentIndex > 0;
  int get historyCount => history.length;
}

/// Error state with user-friendly message
class AiInsightsError extends AiInsightsState {
  const AiInsightsError(this.message);
  final String message;
}

/// Main provider for AI insights feature
/// Manages analysis generation and history navigation
@Riverpod(keepAlive: true)
class AiInsights extends _$AiInsights {
  @override
  Future<AiInsightsState> build() async {
    // Load history on initialization
    final storageRepository = ref.read(aiInsightsStorageRepositoryProvider);
    final history = await storageRepository.getAnalysisHistory();
    
    if (history.isNotEmpty) {
      return AiInsightsWithHistory(
        history: history,
        currentIndex: 0, // Show most recent
      );
    }
    
    return const AiInsightsInitial();
  }

  Future<void> generateAnalysis() async {
    try {
      state = const AsyncValue.data(AiInsightsLoading());

      // Get current portfolio
      final portfolioAsync = ref.read(portfolioNotifierProvider);

      final portfolio = portfolioAsync.maybeWhen(
        data: (tokens) => tokens,
        orElse: () => <PortfolioToken>[],
      );

      if (portfolio.isEmpty) {
        state = const AsyncValue.data(
          AiInsightsError('No portfolio data available. Please connect your wallet first.'),
        );
        return;
      }

      // Generate AI analysis
      final repository = ref.read(aiInsightsRepositoryProvider);
      final analysis = await repository.generatePortfolioAnalysis(portfolio);

      // Save to storage
      final storageRepository = ref.read(aiInsightsStorageRepositoryProvider);
      await storageRepository.saveAnalysis(analysis);
      
      // Reload history
      final updatedHistory = await storageRepository.getAnalysisHistory();
      
      state = AsyncValue.data(
        AiInsightsWithHistory(
          history: updatedHistory,
          currentIndex: 0, // Show the newly generated analysis
        ),
      );
    } catch (e) {
      state = AsyncValue.data(AiInsightsError('Failed to generate analysis: $e'));
    }
  }
  
  void navigateToAnalysis(int index) {
    final currentState = state.valueOrNull;
    if (currentState is AiInsightsWithHistory) {
      if (index >= 0 && index < currentState.history.length) {
        state = AsyncValue.data(
          AiInsightsWithHistory(
            history: currentState.history,
            currentIndex: index,
          ),
        );
      }
    }
  }
  
  void navigateNext() {
    final currentState = state.valueOrNull;
    if (currentState is AiInsightsWithHistory && currentState.hasNext) {
      navigateToAnalysis(currentState.currentIndex + 1);
    }
  }
  
  void navigatePrevious() {
    final currentState = state.valueOrNull;
    if (currentState is AiInsightsWithHistory && currentState.hasPrevious) {
      navigateToAnalysis(currentState.currentIndex - 1);
    }
  }

  Future<void> clearHistory() async {
    final storageRepository = ref.read(aiInsightsStorageRepositoryProvider);
    await storageRepository.clearHistory();
    state = const AsyncValue.data(AiInsightsInitial());
  }
}

@riverpod
Future<String> quickInsight(QuickInsightRef ref) async {
  try {
    // Get current portfolio
    final portfolioAsync = ref.watch(portfolioNotifierProvider);

    final portfolio = portfolioAsync.maybeWhen(
      data: (tokens) => tokens,
      orElse: () => <PortfolioToken>[],
    );

    if (portfolio.isEmpty) {
      return 'Connect your wallet to get AI insights about your portfolio.';
    }

    // Generate quick insight
    final repository = ref.read(aiInsightsRepositoryProvider);
    return await repository.generateQuickInsight(portfolio);
  } catch (e) {
    return 'Unable to generate insight at this time.';
  }
}

@riverpod
bool canGenerateAnalysis(CanGenerateAnalysisRef ref) {
  final portfolioAsync = ref.watch(portfolioNotifierProvider);
  final aiStateAsync = ref.watch(aiInsightsProvider);

  final hasPortfolio = portfolioAsync.maybeWhen(
    data: (tokens) => tokens.isNotEmpty,
    orElse: () => false,
  );

  final aiState = aiStateAsync.valueOrNull;
  final isNotLoading = aiState is! AiInsightsLoading;

  return hasPortfolio && isNotLoading;
}
