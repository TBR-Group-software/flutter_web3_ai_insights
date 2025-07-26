// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentRecommendation _$InvestmentRecommendationFromJson(
  Map<String, dynamic> json,
) => InvestmentRecommendation(
  title: json['title'] as String,
  description: json['description'] as String,
  type: $enumDecode(_$RecommendationTypeEnumMap, json['type']),
  priority: $enumDecode(_$RecommendationPriorityEnumMap, json['priority']),
  targetSymbol: json['targetSymbol'] as String?,
  targetPercentage: (json['targetPercentage'] as num?)?.toDouble(),
  reasoning: json['reasoning'] as String?,
);

Map<String, dynamic> _$InvestmentRecommendationToJson(
  InvestmentRecommendation instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'type': _$RecommendationTypeEnumMap[instance.type]!,
  'priority': _$RecommendationPriorityEnumMap[instance.priority]!,
  'targetSymbol': instance.targetSymbol,
  'targetPercentage': instance.targetPercentage,
  'reasoning': instance.reasoning,
};

const _$RecommendationTypeEnumMap = {
  RecommendationType.buy: 'buy',
  RecommendationType.sell: 'sell',
  RecommendationType.hold: 'hold',
  RecommendationType.rebalance: 'rebalance',
  RecommendationType.diversify: 'diversify',
};

const _$RecommendationPriorityEnumMap = {
  RecommendationPriority.high: 'high',
  RecommendationPriority.medium: 'medium',
  RecommendationPriority.low: 'low',
};
