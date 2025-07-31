import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';

/// Abstract interface for AI insights storage service
abstract class AiInsightsStorageService {
  /// Load the history of AI analyses from storage
  Future<List<PortfolioAnalysis>> loadHistory();

  /// Save a new analysis to storage
  Future<void> saveAnalysis(PortfolioAnalysis analysis);

  /// Clear all analysis history from storage
  Future<void> clearHistory();

  /// Get the most recent analysis from storage
  Future<PortfolioAnalysis?> getLatestAnalysis();

  /// Get the count of analyses in history
  Future<int> getHistoryCount();
}
