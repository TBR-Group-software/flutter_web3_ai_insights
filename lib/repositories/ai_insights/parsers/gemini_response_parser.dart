import 'package:logger/logger.dart';
import 'package:web3_ai_assistant/core/utils/validators.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_response.dart';

/// Parses and validates responses from Gemini AI API
class GeminiResponseParser {
  GeminiResponseParser({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  String? parseTextResponse(GenerateContentResponse response) {
    try {
      // Validate response structure
      if (response.candidates.isEmpty) {
        _logger.w('No candidates in response');
        return null;
      }
      
      // Check for prompt feedback issues
      if (response.promptFeedback?.blockReason != null) {
        _logger.w('Prompt was blocked: ${response.promptFeedback!.blockReason}');
        return null;
      }

      // Extract text from the first candidate
      final text = response.text;
      if (text == null || text.isEmpty) {
        _logger.w('No text content found in response');
        return null;
      }

      // Sanitize the response text
      final sanitizedText = Validators.sanitizeInput(text.trim());
      return sanitizedText;
    } catch (e) {
      _logger.e('Error parsing Gemini response: $e');
      return null;
    }
  }

  bool isResponseSafe(GenerateContentResponse response) {
    // Check prompt feedback safety ratings
    final promptSafetyRatings = response.promptFeedback?.safetyRatings ?? [];
    for (final rating in promptSafetyRatings) {
      if (_isHighRiskRating(rating)) {
        _logger.w('Unsafe prompt detected: ${rating.category} - ${rating.probability}');
        return false;
      }
    }

    // Check candidate safety ratings
    for (final candidate in response.candidates) {
      final candidateSafetyRatings = candidate.safetyRatings ?? [];
      for (final rating in candidateSafetyRatings) {
        if (_isHighRiskRating(rating)) {
          _logger.w('Unsafe content detected: ${rating.category} - ${rating.probability}');
          return false;
        }
      }
    }

    return true;
  }

  bool _isHighRiskRating(SafetyRating rating) {
    // Consider HIGH probability as unsafe
    return rating.probability.toUpperCase() == 'HIGH' || rating.probability.toUpperCase() == 'VERY_HIGH';
  }

  Map<String, dynamic> extractUsageMetadata(GenerateContentResponse response) {
    final usage = response.usageMetadata;
    return {
      'promptTokens': usage?.promptTokenCount ?? 0,
      'completionTokens': usage?.candidatesTokenCount ?? 0,
      'totalTokens': usage?.totalTokenCount ?? 0,
    };
  }
}
