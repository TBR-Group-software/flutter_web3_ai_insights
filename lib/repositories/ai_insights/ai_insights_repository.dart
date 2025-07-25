import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

abstract class AiInsightsRepository {
  Future<PortfolioAnalysis> generatePortfolioAnalysis(List<PortfolioToken> tokens);
  Future<String> generateQuickInsight(List<PortfolioToken> tokens);
  Future<void> clearCache();
}
