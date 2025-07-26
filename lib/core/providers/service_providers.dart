import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/web3_service_impl.dart';
import 'package:web3_ai_assistant/services/binance_rest/binance_rest_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/binance_websocket_service.dart';
import 'package:web3_ai_assistant/services/binance_websocket/binance_websocket_service_impl.dart';
import 'package:web3_ai_assistant/services/gemini/gemini_service.dart';
import 'package:web3_ai_assistant/services/storage/ai_insights_storage_service.dart';
import 'package:web3_ai_assistant/services/storage/ai_insights_storage_service_impl.dart';

part 'service_providers.g.dart';

@riverpod
Web3Service web3Service(Web3ServiceRef ref) {
  final service = Web3ServiceImpl();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
BinanceRestService binanceRestService(BinanceRestServiceRef ref) {
  final dio = Dio(
    BaseOptions(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 30)),
  );
  return BinanceRestService(dio);
}

@riverpod
BinanceWebSocketService binanceWebSocketService(BinanceWebSocketServiceRef ref) {
  final service = BinanceWebSocketServiceImpl();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
GeminiService geminiService(GeminiServiceRef ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  return GeminiService(dio);
}

@riverpod
String geminiApiKey(GeminiApiKeyRef ref) {
  final apiKey = dotenv.env['GEMINI_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('GEMINI_API_KEY not found in environment variables');
  }
  return apiKey;
}

@riverpod
String geminiModel(GeminiModelRef ref) {
  return dotenv.env['MODEL_NAME'] ?? 'gemini-2.0-flash';
}

@riverpod
AiInsightsStorageService aiInsightsStorageService(AiInsightsStorageServiceRef ref) {
  return AiInsightsStorageServiceImpl();
}
