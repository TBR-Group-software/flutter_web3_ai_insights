import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class WalletConnectionButton extends ConsumerWidget {
  const WalletConnectionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletNotifierProvider);
    final theme = Theme.of(context);

    return walletState.when(
      data: (state) {
        if (state.isConnected) {
          return OutlinedButton.icon(
            onPressed: () async {
              await ref.read(walletNotifierProvider.notifier).disconnect();
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Disconnect'),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
              side: BorderSide(color: theme.colorScheme.error),
            ),
          );
        }

        return FilledButton.icon(
          onPressed:
              state.isLoading
                  ? null
                  : () async {
                    await ref.read(walletNotifierProvider.notifier).connect();
                  },
          icon:
              state.isLoading
                  ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onPrimary),
                  )
                  : const Icon(Icons.account_balance_wallet_rounded),
          label: Text(state.isLoading ? 'Connecting...' : 'Connect MetaMask'),
        );
      },
      loading:
          () => FilledButton.icon(
            onPressed: null,
            icon: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onSurfaceVariant),
            ),
            label: const Text('Loading...'),
          ),
      error:
          (error, _) => FilledButton.icon(
            onPressed: () async {
              await ref.read(walletNotifierProvider.notifier).connect();
            },
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry Connection'),
            style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
          ),
    );
  }
}
