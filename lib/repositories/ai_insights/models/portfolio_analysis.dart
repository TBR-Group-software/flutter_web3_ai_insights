import 'package:json_annotation/json_annotation.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/risk_assessment.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/investment_recommendation.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/market_insight.dart';

part 'portfolio_analysis.g.dart';

@JsonSerializable()
class PortfolioAnalysis {
  const PortfolioAnalysis({
    required this.id,
    required this.generatedAt,
    required this.overview,
    required this.riskAssessment,
    required this.performanceSummary,
    required this.recommendations,
    required this.marketInsights,
    required this.portfolioValue,
    required this.tokenCount,
    this.rawAnalysis,
  });

  factory PortfolioAnalysis.fromJson(Map<String, dynamic> json) => _$PortfolioAnalysisFromJson(json);

  final String id;
  final DateTime generatedAt;
  final String overview;
  final RiskAssessment riskAssessment;
  final String performanceSummary;
  final List<InvestmentRecommendation> recommendations;
  final List<MarketInsight> marketInsights;
  final double portfolioValue;
  final int tokenCount;
  final String? rawAnalysis;

  Map<String, dynamic> toJson() => _$PortfolioAnalysisToJson(this);
}
