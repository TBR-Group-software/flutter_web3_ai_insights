import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/web3_service_impl.dart';

part 'service_providers.g.dart';

@riverpod
Web3Service web3Service(Web3ServiceRef ref) {
  final service = Web3ServiceImpl();
  ref.onDispose(service.dispose);
  return service;
}
