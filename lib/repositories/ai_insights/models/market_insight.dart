import 'package:json_annotation/json_annotation.dart';

part 'market_insight.g.dart';

enum InsightType { trend, opportunity, warning, news }

@JsonSerializable()
class MarketInsight {
  const MarketInsight({
    required this.title,
    required this.description,
    required this.type,
    this.affectedTokens,
    this.impact,
  });

  factory MarketInsight.fromJson(Map<String, dynamic> json) => _$MarketInsightFromJson(json);

  final String title;
  final String description;
  final InsightType type;
  final List<String>? affectedTokens;
  final String? impact;

  Map<String, dynamic> toJson() => _$MarketInsightToJson(this);
}
