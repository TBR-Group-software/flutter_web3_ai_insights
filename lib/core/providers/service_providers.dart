import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/web3_service_impl.dart';
import 'package:web3_ai_assistant/services/market_data/market_data_service.dart';
import 'package:web3_ai_assistant/services/market_data/binance_service.dart';
import 'package:web3_ai_assistant/services/blockchain/blockchain_service.dart';
import 'package:web3_ai_assistant/services/blockchain/blockchain_service_impl.dart';

part 'service_providers.g.dart';

@riverpod
Web3Service web3Service(Web3ServiceRef ref) {
  final service = Web3ServiceImpl();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
MarketDataService marketDataService(MarketDataServiceRef ref) {
  final service = BinanceService();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
BlockchainService blockchainService(BlockchainServiceRef ref) {
  final web3Service = ref.watch(web3ServiceProvider);
  final service = BlockchainServiceImpl(web3Service: web3Service);
  ref.onDispose(service.dispose);
  return service;
}
