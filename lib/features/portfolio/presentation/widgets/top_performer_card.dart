import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

class TopPerformerCard extends StatelessWidget {
  const TopPerformerCard({
    super.key,
    required this.tokens,
  });

  final List<PortfolioToken> tokens;

  @override
  Widget build(BuildContext context) {
    if (tokens.isEmpty) {
      return const SizedBox.shrink();
    }

    final topPerformer = tokens.reduce((a, b) => 
        a.changePercent24h > b.changePercent24h ? a : b,);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Top Performer: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(
            topPerformer.symbol.toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          Text(
            '${topPerformer.changePercent24h >= 0 ? '+' : ''}${topPerformer.changePercent24h.toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: topPerformer.changePercent24h >= 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.error,
                ),
          ),
        ],
      ),
    );
  }
}
