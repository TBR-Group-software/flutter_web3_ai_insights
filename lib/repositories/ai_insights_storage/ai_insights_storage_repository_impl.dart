import 'package:web3_ai_assistant/repositories/ai_insights_storage/ai_insights_storage_repository.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/services/storage/ai_insights_storage_service.dart';

class AiInsightsStorageRepositoryImpl implements AiInsightsStorageRepository {
  const AiInsightsStorageRepositoryImpl({
    required AiInsightsStorageService storageService,
  }) : _storageService = storageService;

  final AiInsightsStorageService _storageService;

  @override
  Future<List<PortfolioAnalysis>> getAnalysisHistory() async {
    return _storageService.loadHistory();
  }

  @override
  Future<void> saveAnalysis(PortfolioAnalysis analysis) async {
    await _storageService.saveAnalysis(analysis);
  }

  @override
  Future<void> clearHistory() async {
    await _storageService.clearHistory();
  }

  @override
  Future<PortfolioAnalysis?> getLatestAnalysis() async {
    return _storageService.getLatestAnalysis();
  }

  @override
  Future<int> getHistoryCount() async {
    return _storageService.getHistoryCount();
  }
}
