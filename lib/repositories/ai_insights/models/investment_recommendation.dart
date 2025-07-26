import 'package:json_annotation/json_annotation.dart';

part 'investment_recommendation.g.dart';

enum RecommendationType { buy, sell, hold, rebalance, diversify }

enum RecommendationPriority { high, medium, low }

@JsonSerializable()
class InvestmentRecommendation {
  const InvestmentRecommendation({
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    this.targetSymbol,
    this.targetPercentage,
    this.reasoning,
  });

  factory InvestmentRecommendation.fromJson(Map<String, dynamic> json) => _$InvestmentRecommendationFromJson(json);

  final String title;
  final String description;
  final RecommendationType type;
  final RecommendationPriority priority;
  final String? targetSymbol;
  final double? targetPercentage;
  final String? reasoning;

  Map<String, dynamic> toJson() => _$InvestmentRecommendationToJson(this);
}
