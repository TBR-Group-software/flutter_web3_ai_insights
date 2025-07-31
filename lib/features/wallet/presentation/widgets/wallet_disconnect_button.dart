import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class WalletDisconnectButton extends ConsumerWidget {
  const WalletDisconnectButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
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
          label: Text(l10n.walletDisconnect),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
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
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.walletDisconnectConfirmTitle),
          content: Text(l10n.walletDisconnectConfirmMessage),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(l10n.cancel)),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
              child: Text(l10n.walletDisconnect),
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
