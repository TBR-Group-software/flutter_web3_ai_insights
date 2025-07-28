import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/loading_skeleton.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/realtime_indicator.dart';
import 'package:web3_ai_assistant/features/portfolio/providers/portfolio_providers.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class PortfolioSummaryCard extends ConsumerWidget {
  const PortfolioSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final portfolioStreamAsync = ref.watch(portfolioStreamProvider);
    final walletStateAsync = ref.watch(walletNotifierProvider);

    return Card(
      elevation: 0,
      child: walletStateAsync.when(
        data:
            (walletState) => InkWell(
              onTap:
                  walletState.isConnected
                      ? () {
                        // Navigate to portfolio
                      }
                      : null,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet_rounded, color: theme.colorScheme.primary, size: 24),
                        const SizedBox(width: AppSpacing.sm),
                        Text(l10n.portfolioValue, style: theme.textTheme.titleMedium),
                        const Spacer(),
                        if (walletState.isConnected)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(color: theme.colorScheme.tertiary, shape: BoxShape.circle),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  l10n.walletConnected,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.tertiary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (portfolioStreamAsync.hasValue) ...[
                          const SizedBox(width: AppSpacing.sm),
                          const RealtimeIndicator(),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (walletState.isConnected) ...[
                      portfolioStreamAsync.when(
                        data: (portfolio) {
                          final totalValue = portfolio.fold<double>(0, (sum, token) => sum + token.totalValue);
                          final totalChange = portfolio.fold<double>(0, (sum, token) => sum + (token.balance * token.change24h));
                          final changePercent = totalValue > 0 ? (totalChange / (totalValue - totalChange)) * 100 : 0.0;
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.currencyValue(totalValue.toStringAsFixed(2)),
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Row(
                                children: [
                                  Icon(
                                    changePercent >= 0 ? Icons.trending_up : Icons.trending_down,
                                    color: changePercent >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error,
                                    size: 16,
                                  ),
                                  const SizedBox(width: AppSpacing.xs),
                                  Text(
                                    l10n.percentageChange('${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}'),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: changePercent >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        loading: () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LoadingSkeleton.text(
                              width: 150,
                              height: 40, // headlineLarge: 32px * 1.25 = 40px
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            LoadingSkeleton.text(
                              width: 100,
                              height: 20, // bodyMedium: 14px * 1.43 = 20px
                            ),
                          ],
                        ),
                        error: (error, _) => Text(
                          l10n.portfolioErrorLoading,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ] else ...[
                      Container(
                        height: 80,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.walletNoConnection,
                              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              l10n.walletConnectToView,
                              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        loading:
            () => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet_rounded, color: theme.colorScheme.primary, size: 24),
                      const SizedBox(width: AppSpacing.sm),
                      Text(l10n.portfolioValue, style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LoadingSkeleton.text(width: 150, height: 40), // headlineLarge
                  const SizedBox(height: AppSpacing.xs),
                  LoadingSkeleton.text(width: 100, height: 20), // bodyMedium
                ],
              ),
            ),
        error:
            (error, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Center(child: Text(l10n.errorLoadingWalletState)),
            ),
      ),
    );
  }
}
