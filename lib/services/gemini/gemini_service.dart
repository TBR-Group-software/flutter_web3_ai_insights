import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_request.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_response.dart';

part 'gemini_service.g.dart';

/// REST API client for Google's Gemini AI service
/// Handles content generation requests for portfolio analysis
@RestApi()
abstract class GeminiService {
  factory GeminiService(Dio dio, {String? baseUrl}) = _GeminiService;

  /// Generates AI content using specified Gemini model
  /// Model format: 'gemini-2.0-flash' or similar
  /// Requires valid API key for authentication
  @POST('/v1beta/models/{model}:generateContent')
  Future<GenerateContentResponse> generateContent(
    @Path('model') String model,
    @Body() GenerateContentRequest request,
    @Query('key') String apiKey,
  );
}
