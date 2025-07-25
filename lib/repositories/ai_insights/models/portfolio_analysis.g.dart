// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioAnalysis _$PortfolioAnalysisFromJson(
  Map<String, dynamic> json,
) => PortfolioAnalysis(
  id: json['id'] as String,
  generatedAt: DateTime.parse(json['generatedAt'] as String),
  overview: json['overview'] as String,
  riskAssessment: RiskAssessment.fromJson(
    json['riskAssessment'] as Map<String, dynamic>,
  ),
  performanceSummary: json['performanceSummary'] as String,
  recommendations:
      (json['recommendations'] as List<dynamic>)
          .map(
            (e) => InvestmentRecommendation.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  marketInsights:
      (json['marketInsights'] as List<dynamic>)
          .map((e) => MarketInsight.fromJson(e as Map<String, dynamic>))
          .toList(),
  portfolioValue: (json['portfolioValue'] as num).toDouble(),
  tokenCount: (json['tokenCount'] as num).toInt(),
  rawAnalysis: json['rawAnalysis'] as String?,
);

Map<String, dynamic> _$PortfolioAnalysisToJson(PortfolioAnalysis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'overview': instance.overview,
      'riskAssessment': instance.riskAssessment,
      'performanceSummary': instance.performanceSummary,
      'recommendations': instance.recommendations,
      'marketInsights': instance.marketInsights,
      'portfolioValue': instance.portfolioValue,
      'tokenCount': instance.tokenCount,
      'rawAnalysis': instance.rawAnalysis,
    };
