import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';

abstract class AiInsightsStorageRepository {
  Future<List<PortfolioAnalysis>> getAnalysisHistory();
  Future<void> saveAnalysis(PortfolioAnalysis analysis);
  Future<void> clearHistory();
  Future<PortfolioAnalysis?> getLatestAnalysis();
  Future<int> getHistoryCount();
}
