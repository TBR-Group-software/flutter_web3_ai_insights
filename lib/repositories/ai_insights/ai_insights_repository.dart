import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

/// Repository interface for AI-powered portfolio analysis
/// Generates insights using Gemini AI based on token holdings
abstract class AiInsightsRepository {
  /// Generates comprehensive portfolio analysis with risk assessment
  Future<PortfolioAnalysis> generatePortfolioAnalysis(List<PortfolioToken> tokens);
  
  /// Generates brief insight summary for dashboard preview
  Future<String> generateQuickInsight(List<PortfolioToken> tokens);
  
  /// Clears cached AI responses to force fresh analysis
  Future<void> clearCache();
}
