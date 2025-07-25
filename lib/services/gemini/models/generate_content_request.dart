import 'package:json_annotation/json_annotation.dart';

part 'generate_content_request.g.dart';

@JsonSerializable()
class GenerateContentRequest {
  const GenerateContentRequest({required this.contents, this.generationConfig, this.safetySettings});

  factory GenerateContentRequest.fromJson(Map<String, dynamic> json) => _$GenerateContentRequestFromJson(json);

  final List<Content> contents;
  final GenerationConfig? generationConfig;
  final List<SafetySetting>? safetySettings;

  Map<String, dynamic> toJson() => _$GenerateContentRequestToJson(this);
}

@JsonSerializable()
class Content {
  const Content({required this.parts, this.role = 'user'});

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  final List<Part> parts;
  final String role;

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Part {
  const Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  final String text;

  Map<String, dynamic> toJson() => _$PartToJson(this);
}

@JsonSerializable()
class GenerationConfig {
  const GenerationConfig({
    this.temperature,
    this.topK,
    this.topP,
    this.candidateCount,
    this.maxOutputTokens,
    this.stopSequences,
  });

  factory GenerationConfig.fromJson(Map<String, dynamic> json) => _$GenerationConfigFromJson(json);

  final double? temperature;
  final int? topK;
  final double? topP;
  final int? candidateCount;
  final int? maxOutputTokens;
  final List<String>? stopSequences;

  Map<String, dynamic> toJson() => _$GenerationConfigToJson(this);
}

@JsonSerializable()
class SafetySetting {
  const SafetySetting({required this.category, required this.threshold});

  factory SafetySetting.fromJson(Map<String, dynamic> json) => _$SafetySettingFromJson(json);

  final String category;
  final String threshold;

  Map<String, dynamic> toJson() => _$SafetySettingToJson(this);
}
