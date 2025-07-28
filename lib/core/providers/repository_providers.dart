import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/repositories/wallet/wallet_repository.dart';
import 'package:web3_ai_assistant/repositories/wallet/wallet_repository_impl.dart';
import 'package:web3_ai_assistant/repositories/portfolio/portfolio_repository.dart';
import 'package:web3_ai_assistant/repositories/portfolio/portfolio_repository_impl.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/ai_insights_repository.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/ai_insights_repository_impl.dart';
import 'package:web3_ai_assistant/repositories/ai_insights_storage/ai_insights_storage_repository.dart';
import 'package:web3_ai_assistant/repositories/ai_insights_storage/ai_insights_storage_repository_impl.dart';
import 'package:web3_ai_assistant/repositories/transaction/transaction_repository.dart';
import 'package:web3_ai_assistant/repositories/transaction/transaction_repository_impl.dart';
import 'package:web3_ai_assistant/repositories/market/market_repository.dart';
import 'package:web3_ai_assistant/repositories/market/market_repository_impl.dart';
import 'package:web3_ai_assistant/core/providers/service_providers.dart';

part 'repository_providers.g.dart';

@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) {
  final web3Service = ref.watch(web3ServiceProvider);
  final repository = WalletRepositoryImpl(web3Service);
  ref.onDispose(repository.dispose);
  return repository;
}

@riverpod
PortfolioRepository portfolioRepository(PortfolioRepositoryRef ref) {
  final binanceRestService = ref.watch(binanceRestServiceProvider);
  final binanceWebSocketService = ref.watch(binanceWebSocketServiceProvider);
  final web3Service = ref.watch(web3ServiceProvider);
  final repository = PortfolioRepositoryImpl(
    binanceRestService: binanceRestService,
    binanceWebSocketService: binanceWebSocketService,
    web3Service: web3Service,
  );
  ref.onDispose(repository.dispose);
  return repository;
}

@riverpod
AiInsightsRepository aiInsightsRepository(AiInsightsRepositoryRef ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  final apiKey = ref.watch(geminiApiKeyProvider);
  final modelName = ref.watch(geminiModelProvider);

  final repository = AiInsightsRepositoryImpl(geminiService: geminiService, apiKey: apiKey, modelName: modelName);

  ref.onDispose(repository.clearCache);
  return repository;
}

@riverpod
AiInsightsStorageRepository aiInsightsStorageRepository(AiInsightsStorageRepositoryRef ref) {
  final storageService = ref.watch(aiInsightsStorageServiceProvider);
  return AiInsightsStorageRepositoryImpl(storageService: storageService);
}

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  final web3Service = ref.watch(web3ServiceProvider);
  final repository = TransactionRepositoryImpl(web3Service: web3Service);
  ref.onDispose(repository.dispose);
  return repository;
}

@riverpod
MarketRepository marketRepository(MarketRepositoryRef ref) {
  final binanceRestService = ref.watch(binanceRestServiceProvider);
  final binanceWebSocketService = ref.watch(binanceWebSocketServiceProvider);
  final repository = MarketRepositoryImpl(
    binanceRestService: binanceRestService,
    binanceWebSocketService: binanceWebSocketService,
  );
  ref.onDispose(repository.dispose);
  return repository;
}
