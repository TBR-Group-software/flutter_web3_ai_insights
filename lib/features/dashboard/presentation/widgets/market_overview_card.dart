import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/loading_skeleton.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/market_item.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/realtime_indicator.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';

class MarketOverviewCard extends ConsumerWidget {
  const MarketOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final marketDataAsync = ref.watch(marketOverviewStreamProvider);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up_rounded, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Text('Market Overview', style: theme.textTheme.titleMedium),
                const Spacer(),
                if (marketDataAsync.hasValue) const RealtimeIndicator(),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            marketDataAsync.when(
              data: (marketData) {
                if (marketData.isEmpty) {
                  return Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(
                      'Market data unavailable',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  );
                }
                return Column(
                  children:
                      marketData.map((data) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: MarketItem(
                            symbol: data.symbol,
                            price: data.formattedPrice,
                            change: data.formattedChange,
                            isPositive: data.isPositive,
                          ),
                        );
                      }).toList(),
                );
              },
              loading:
                  () => Column(
                    children: [
                      LoadingSkeleton.text(width: double.infinity, height: 48),
                      const SizedBox(height: AppSpacing.md),
                      LoadingSkeleton.text(width: double.infinity, height: 48),
                      const SizedBox(height: AppSpacing.md),
                      LoadingSkeleton.text(width: double.infinity, height: 48),
                    ],
                  ),
              error:
                  (error, _) => Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: Text(
                      'Error loading market data',
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
