import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_status_widget.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class WalletStatusDisplay extends ConsumerWidget {
  const WalletStatusDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletNotifierProvider);

    return walletState.when(
      data: (state) {
        if (state.error != null) {
          return WalletStatusWidget(
            type: WalletStatusType.error,
            message: state.error,
          );
        }

        if (!state.isConnected) {
          return const WalletStatusWidget(
            type: WalletStatusType.disconnected,
          );
        }

        return WalletStatusWidget(
          type: WalletStatusType.connected,
          networkName: state.walletInfo?.networkName,
        );
      },
      loading: () => const WalletStatusWidget(
        type: WalletStatusType.loading,
      ),
      error: (error, _) => WalletStatusWidget(
        type: WalletStatusType.error,
        message: error.toString(),
      ),
    );
  }

}
