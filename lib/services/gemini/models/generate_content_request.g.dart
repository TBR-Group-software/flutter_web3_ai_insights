// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_content_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateContentRequest _$GenerateContentRequestFromJson(
  Map<String, dynamic> json,
) => GenerateContentRequest(
  contents:
      (json['contents'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
  generationConfig:
      json['generationConfig'] == null
          ? null
          : GenerationConfig.fromJson(
            json['generationConfig'] as Map<String, dynamic>,
          ),
  safetySettings:
      (json['safetySettings'] as List<dynamic>?)
          ?.map((e) => SafetySetting.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GenerateContentRequestToJson(
  GenerateContentRequest instance,
) => <String, dynamic>{
  'contents': instance.contents,
  'generationConfig': instance.generationConfig,
  'safetySettings': instance.safetySettings,
};

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  parts:
      (json['parts'] as List<dynamic>)
          .map((e) => Part.fromJson(e as Map<String, dynamic>))
          .toList(),
  role: json['role'] as String? ?? 'user',
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'parts': instance.parts,
  'role': instance.role,
};

Part _$PartFromJson(Map<String, dynamic> json) =>
    Part(text: json['text'] as String);

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
  'text': instance.text,
};

GenerationConfig _$GenerationConfigFromJson(Map<String, dynamic> json) =>
    GenerationConfig(
      temperature: (json['temperature'] as num?)?.toDouble(),
      topK: (json['topK'] as num?)?.toInt(),
      topP: (json['topP'] as num?)?.toDouble(),
      candidateCount: (json['candidateCount'] as num?)?.toInt(),
      maxOutputTokens: (json['maxOutputTokens'] as num?)?.toInt(),
      stopSequences:
          (json['stopSequences'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$GenerationConfigToJson(GenerationConfig instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'topK': instance.topK,
      'topP': instance.topP,
      'candidateCount': instance.candidateCount,
      'maxOutputTokens': instance.maxOutputTokens,
      'stopSequences': instance.stopSequences,
    };

SafetySetting _$SafetySettingFromJson(Map<String, dynamic> json) =>
    SafetySetting(
      category: json['category'] as String,
      threshold: json['threshold'] as String,
    );

Map<String, dynamic> _$SafetySettingToJson(SafetySetting instance) =>
    <String, dynamic>{
      'category': instance.category,
      'threshold': instance.threshold,
    };
