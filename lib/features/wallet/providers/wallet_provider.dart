import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3_ai_assistant/core/providers/repository_providers.dart';
import 'package:web3_ai_assistant/repositories/wallet/models/wallet_state.dart';

part 'wallet_provider.g.dart';

@riverpod
class WalletNotifier extends _$WalletNotifier {
  @override
  Future<WalletState> build() async {
    final repository = ref.watch(walletRepositoryProvider);
    
    // Listen to wallet state changes
    ref.listen(
      walletStateStreamProvider,
      (previous, next) {
        next.when(
          data: (walletState) {
            state = AsyncValue.data(walletState);
          },
          loading: () {},
          error: (error, stack) {
            state = AsyncValue.error(error, stack);
          },
        );
      },
    );
    
    // Return initial state
    return repository.currentWalletState;
  }

  Future<void> connect() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(walletRepositoryProvider);
      final walletState = await repository.connectWallet();
      state = AsyncValue.data(walletState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> disconnect() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(walletRepositoryProvider);
      final walletState = await repository.disconnectWallet();
      state = AsyncValue.data(walletState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    try {
      final repository = ref.read(walletRepositoryProvider);
      await repository.refreshWalletState();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
Stream<WalletState> walletStateStream(WalletStateStreamRef ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.walletStateStream;
}
