import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/loading_skeleton.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/transaction_item.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class RecentTransactionsCard extends ConsumerWidget {
  const RecentTransactionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final transactionsAsync = ref.watch(recentTransactionsProvider);
    final walletStateAsync = ref.watch(walletNotifierProvider);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.history_rounded, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Text(l10n.transactionsRecent, style: theme.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            walletStateAsync.when(
              data: (walletState) {
                if (walletState.isConnected) {
                  return transactionsAsync.when(
                    data: (transactions) {
                      if (transactions.isEmpty) {
                        return Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.transactionsNone,
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        );
                      }
                      return Column(children: transactions.map((tx) => TransactionItem(transaction: tx)).toList());
                    },
                    loading:
                        () => Column(
                          children: [
                            LoadingSkeleton.text(width: double.infinity, height: 60),
                            const SizedBox(height: AppSpacing.sm),
                            LoadingSkeleton.text(width: double.infinity, height: 60),
                            const SizedBox(height: AppSpacing.sm),
                            LoadingSkeleton.text(width: double.infinity, height: 60),
                          ],
                        ),
                    error:
                        (error, _) => Container(
                          height: 120,
                          alignment: Alignment.center,
                          child: Text(
                            l10n.transactionsErrorLoading,
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                          ),
                        ),
                  );
                } else {
                  return Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(
                      l10n.transactionsConnectWallet,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  );
                }
              },
              loading:
                  () => Column(
                    children: [
                      LoadingSkeleton.text(width: double.infinity, height: 60),
                      const SizedBox(height: AppSpacing.sm),
                      LoadingSkeleton.text(width: double.infinity, height: 60),
                      const SizedBox(height: AppSpacing.sm),
                      LoadingSkeleton.text(width: double.infinity, height: 60),
                    ],
                  ),
              error:
                  (error, _) => Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(
                      l10n.errorLoadingWalletState,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
