import 'package:json_annotation/json_annotation.dart';

part 'generate_content_response.g.dart';

@JsonSerializable()
class GenerateContentResponse {
  const GenerateContentResponse({required this.candidates, this.promptFeedback, this.usageMetadata});

  factory GenerateContentResponse.fromJson(Map<String, dynamic> json) => _$GenerateContentResponseFromJson(json);

  final List<Candidate> candidates;
  final PromptFeedback? promptFeedback;
  final UsageMetadata? usageMetadata;

  Map<String, dynamic> toJson() => _$GenerateContentResponseToJson(this);

  String? get text {
    if (candidates.isEmpty) {
      return null;
    }
    final firstCandidate = candidates.first;
    if (firstCandidate.content.parts.isEmpty) {
      return null;
    }
    return firstCandidate.content.parts.first.text;
  }
}

@JsonSerializable()
class Candidate {
  const Candidate({required this.content, this.finishReason, this.index, this.safetyRatings});

  factory Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

  final CandidateContent content;
  final String? finishReason;
  final int? index;
  final List<SafetyRating>? safetyRatings;

  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}

@JsonSerializable()
class CandidateContent {
  const CandidateContent({required this.parts, this.role});

  factory CandidateContent.fromJson(Map<String, dynamic> json) => _$CandidateContentFromJson(json);

  final List<ContentPart> parts;
  final String? role;

  Map<String, dynamic> toJson() => _$CandidateContentToJson(this);
}

@JsonSerializable()
class ContentPart {
  const ContentPart({required this.text});

  factory ContentPart.fromJson(Map<String, dynamic> json) => _$ContentPartFromJson(json);

  final String text;

  Map<String, dynamic> toJson() => _$ContentPartToJson(this);
}

@JsonSerializable()
class PromptFeedback {
  const PromptFeedback({this.blockReason, this.safetyRatings});

  factory PromptFeedback.fromJson(Map<String, dynamic> json) => _$PromptFeedbackFromJson(json);

  final String? blockReason;
  final List<SafetyRating>? safetyRatings;

  Map<String, dynamic> toJson() => _$PromptFeedbackToJson(this);
}

@JsonSerializable()
class SafetyRating {
  const SafetyRating({required this.category, required this.probability});

  factory SafetyRating.fromJson(Map<String, dynamic> json) => _$SafetyRatingFromJson(json);

  final String category;
  final String probability;

  Map<String, dynamic> toJson() => _$SafetyRatingToJson(this);
}

@JsonSerializable()
class UsageMetadata {
  const UsageMetadata({this.promptTokenCount, this.candidatesTokenCount, this.totalTokenCount});

  factory UsageMetadata.fromJson(Map<String, dynamic> json) => _$UsageMetadataFromJson(json);

  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;

  Map<String, dynamic> toJson() => _$UsageMetadataToJson(this);
}
