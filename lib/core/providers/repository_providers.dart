import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/repositories/wallet/wallet_repository.dart';
import 'package:web3_ai_assistant/repositories/wallet/wallet_repository_impl.dart';
import 'package:web3_ai_assistant/core/providers/service_providers.dart';

part 'repository_providers.g.dart';

@riverpod
WalletRepository walletRepository(WalletRepositoryRef ref) {
  final web3Service = ref.watch(web3ServiceProvider);
  final repository = WalletRepositoryImpl(web3Service);
  ref.onDispose(repository.dispose);
  return repository;
}
