// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskAssessment _$RiskAssessmentFromJson(Map<String, dynamic> json) =>
    RiskAssessment(
      level: $enumDecode(_$RiskLevelEnumMap, json['level']),
      description: json['description'] as String,
      concentrationRisks:
          (json['concentrationRisks'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      volatilityRisks:
          (json['volatilityRisks'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      mitigationStrategies:
          (json['mitigationStrategies'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      riskScore: (json['riskScore'] as num).toDouble(),
    );

Map<String, dynamic> _$RiskAssessmentToJson(RiskAssessment instance) =>
    <String, dynamic>{
      'level': _$RiskLevelEnumMap[instance.level]!,
      'description': instance.description,
      'concentrationRisks': instance.concentrationRisks,
      'volatilityRisks': instance.volatilityRisks,
      'mitigationStrategies': instance.mitigationStrategies,
      'riskScore': instance.riskScore,
    };

const _$RiskLevelEnumMap = {
  RiskLevel.low: 'low',
  RiskLevel.medium: 'medium',
  RiskLevel.high: 'high',
};
