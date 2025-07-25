import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/priority_chip.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/investment_recommendation.dart';

class RecommendationsList extends StatelessWidget {
  const RecommendationsList({super.key, required this.recommendations});

  final List<InvestmentRecommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outlined, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Text('Recommendations', style: theme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            if (recommendations.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    'No recommendations available',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              ...recommendations.map(
                (recommendation) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _RecommendationItem(recommendation: recommendation),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationItem extends StatelessWidget {
  const _RecommendationItem({required this.recommendation});

  final InvestmentRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getTypeColor(recommendation.type).withAlpha(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getTypeIcon(recommendation.type), size: 20, color: _getTypeColor(recommendation.type)),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(recommendation.title, style: theme.textTheme.titleMedium)),
                PriorityChip(priority: recommendation.priority),
              ],
            ),
            if (recommendation.description != recommendation.title) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(recommendation.description, style: theme.textTheme.bodyMedium),
            ],
            if (recommendation.targetSymbol != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(Icons.currency_bitcoin, size: 16, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    recommendation.targetSymbol!,
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (recommendation.targetPercentage != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    Text('${recommendation.targetPercentage!.toStringAsFixed(1)}%', style: theme.textTheme.bodySmall),
                  ],
                ],
              ),
            ],
            if (recommendation.reasoning != null && recommendation.reasoning!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        recommendation.reasoning!,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(RecommendationType type) {
    switch (type) {
      case RecommendationType.buy:
        return Icons.add_circle_outline;
      case RecommendationType.sell:
        return Icons.remove_circle_outline;
      case RecommendationType.hold:
        return Icons.pause_circle_outline;
      case RecommendationType.rebalance:
        return Icons.balance;
      case RecommendationType.diversify:
        return Icons.hub_outlined;
    }
  }

  Color _getTypeColor(RecommendationType type) {
    switch (type) {
      case RecommendationType.buy:
        return Colors.green;
      case RecommendationType.sell:
        return Colors.red;
      case RecommendationType.hold:
        return Colors.blue;
      case RecommendationType.rebalance:
        return Colors.orange;
      case RecommendationType.diversify:
        return Colors.purple;
    }
  }
}
