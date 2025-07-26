import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_request.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_response.dart';

part 'gemini_service.g.dart';

@RestApi(baseUrl: 'https://generativelanguage.googleapis.com')
abstract class GeminiService {
  factory GeminiService(Dio dio, {String? baseUrl}) = _GeminiService;

  @POST('/v1beta/models/{model}:generateContent')
  Future<GenerateContentResponse> generateContent(
    @Path('model') String model,
    @Body() GenerateContentRequest request,
    @Query('key') String apiKey,
  );
}
