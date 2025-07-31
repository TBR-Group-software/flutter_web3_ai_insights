// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_content_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenerateContentResponse _$GenerateContentResponseFromJson(
  Map<String, dynamic> json,
) => GenerateContentResponse(
  candidates:
      (json['candidates'] as List<dynamic>)
          .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
  promptFeedback:
      json['promptFeedback'] == null
          ? null
          : PromptFeedback.fromJson(
            json['promptFeedback'] as Map<String, dynamic>,
          ),
  usageMetadata:
      json['usageMetadata'] == null
          ? null
          : UsageMetadata.fromJson(
            json['usageMetadata'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$GenerateContentResponseToJson(
  GenerateContentResponse instance,
) => <String, dynamic>{
  'candidates': instance.candidates,
  'promptFeedback': instance.promptFeedback,
  'usageMetadata': instance.usageMetadata,
};

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
  content: CandidateContent.fromJson(json['content'] as Map<String, dynamic>),
  finishReason: json['finishReason'] as String?,
  index: (json['index'] as num?)?.toInt(),
  safetyRatings:
      (json['safetyRatings'] as List<dynamic>?)
          ?.map((e) => SafetyRating.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
  'content': instance.content,
  'finishReason': instance.finishReason,
  'index': instance.index,
  'safetyRatings': instance.safetyRatings,
};

CandidateContent _$CandidateContentFromJson(Map<String, dynamic> json) =>
    CandidateContent(
      parts:
          (json['parts'] as List<dynamic>)
              .map((e) => ContentPart.fromJson(e as Map<String, dynamic>))
              .toList(),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$CandidateContentToJson(CandidateContent instance) =>
    <String, dynamic>{'parts': instance.parts, 'role': instance.role};

ContentPart _$ContentPartFromJson(Map<String, dynamic> json) =>
    ContentPart(text: json['text'] as String);

Map<String, dynamic> _$ContentPartToJson(ContentPart instance) =>
    <String, dynamic>{'text': instance.text};

PromptFeedback _$PromptFeedbackFromJson(Map<String, dynamic> json) =>
    PromptFeedback(
      blockReason: json['blockReason'] as String?,
      safetyRatings:
          (json['safetyRatings'] as List<dynamic>?)
              ?.map((e) => SafetyRating.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$PromptFeedbackToJson(PromptFeedback instance) =>
    <String, dynamic>{
      'blockReason': instance.blockReason,
      'safetyRatings': instance.safetyRatings,
    };

SafetyRating _$SafetyRatingFromJson(Map<String, dynamic> json) => SafetyRating(
  category: json['category'] as String,
  probability: json['probability'] as String,
);

Map<String, dynamic> _$SafetyRatingToJson(SafetyRating instance) =>
    <String, dynamic>{
      'category': instance.category,
      'probability': instance.probability,
    };

UsageMetadata _$UsageMetadataFromJson(Map<String, dynamic> json) =>
    UsageMetadata(
      promptTokenCount: (json['promptTokenCount'] as num?)?.toInt(),
      candidatesTokenCount: (json['candidatesTokenCount'] as num?)?.toInt(),
      totalTokenCount: (json['totalTokenCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UsageMetadataToJson(UsageMetadata instance) =>
    <String, dynamic>{
      'promptTokenCount': instance.promptTokenCount,
      'candidatesTokenCount': instance.candidatesTokenCount,
      'totalTokenCount': instance.totalTokenCount,
    };
