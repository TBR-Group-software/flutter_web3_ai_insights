// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_insight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketInsight _$MarketInsightFromJson(Map<String, dynamic> json) =>
    MarketInsight(
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$InsightTypeEnumMap, json['type']),
      affectedTokens:
          (json['affectedTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      impact: json['impact'] as String?,
    );

Map<String, dynamic> _$MarketInsightToJson(MarketInsight instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': _$InsightTypeEnumMap[instance.type]!,
      'affectedTokens': instance.affectedTokens,
      'impact': instance.impact,
    };

const _$InsightTypeEnumMap = {
  InsightType.trend: 'trend',
  InsightType.opportunity: 'opportunity',
  InsightType.warning: 'warning',
  InsightType.news: 'news',
};
