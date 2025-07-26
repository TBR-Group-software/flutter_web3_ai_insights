import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/market_item.dart';

class MarketOverviewCard extends ConsumerWidget {
  const MarketOverviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

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
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const MarketItem(symbol: 'BTC', price: r'$67,245.32', change: '+2.45%', isPositive: true),
            const SizedBox(height: AppSpacing.md),
            const MarketItem(symbol: 'ETH', price: r'$3,421.18', change: '-0.82%', isPositive: false),
            const SizedBox(height: AppSpacing.md),
            const MarketItem(symbol: 'BNB', price: r'$582.64', change: '+5.21%', isPositive: true),
          ],
        ),
      ),
    );
  }
}
