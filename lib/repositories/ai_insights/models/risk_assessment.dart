import 'package:json_annotation/json_annotation.dart';

part 'risk_assessment.g.dart';

enum RiskLevel { low, medium, high }

@JsonSerializable()
class RiskAssessment {
  const RiskAssessment({
    required this.level,
    required this.description,
    required this.concentrationRisks,
    required this.volatilityRisks,
    required this.mitigationStrategies,
    required this.riskScore, // 0-100
  });

  factory RiskAssessment.fromJson(Map<String, dynamic> json) => _$RiskAssessmentFromJson(json);

  final RiskLevel level;
  final String description;
  final List<String> concentrationRisks;
  final List<String> volatilityRisks;
  final List<String> mitigationStrategies;
  final double riskScore;

  Map<String, dynamic> toJson() => _$RiskAssessmentToJson(this);
}
