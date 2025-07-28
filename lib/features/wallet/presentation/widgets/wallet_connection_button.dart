import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class WalletConnectionButton extends ConsumerWidget {
  const WalletConnectionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
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
            label: Text(l10n.walletDisconnect),
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
          label: Text(state.isLoading ? l10n.walletConnecting : l10n.walletConnect),
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
            label: Text(l10n.walletLoading),
          ),
      error:
          (error, _) => FilledButton.icon(
            onPressed: () async {
              await ref.read(walletNotifierProvider.notifier).connect();
            },
            icon: const Icon(Icons.refresh_rounded),
            label: Text(l10n.walletRetryConnection),
            style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
          ),
    );
  }
}
