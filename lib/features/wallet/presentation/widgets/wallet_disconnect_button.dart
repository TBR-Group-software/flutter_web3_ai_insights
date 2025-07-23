import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class WalletDisconnectButton extends ConsumerWidget {
  const WalletDisconnectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletNotifierProvider);
    final theme = Theme.of(context);

    return walletState.maybeWhen(
      data: (state) {
        if (!state.isConnected) {
          return const SizedBox.shrink();
        }

        return TextButton.icon(
          onPressed: () => _showDisconnectDialog(context, ref),
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Disconnect Wallet'),
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Future<void> _showDisconnectDialog(BuildContext context, WidgetRef ref) async {
    final theme = Theme.of(context);
    
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Disconnect Wallet'),
          content: const Text(
            'Are you sure you want to disconnect your wallet? You can reconnect at any time.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              child: const Text('Disconnect'),
            ),
          ],
        );
      },
    );

    if (result ?? false) {
      await ref.read(walletNotifierProvider.notifier).disconnect();
    }
  }
}
