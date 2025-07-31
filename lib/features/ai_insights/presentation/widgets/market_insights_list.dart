import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/market_insight.dart';

class MarketInsightsList extends StatelessWidget {
  const MarketInsightsList({super.key, required this.insights});

  final List<MarketInsight> insights;

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
                Icon(Icons.insights, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Text('Market Insights', style: theme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            if (insights.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    'No market insights available',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              )
            else
              ...insights.map(
                (insight) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _MarketInsightItem(insight: insight),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MarketInsightItem extends StatelessWidget {
  const _MarketInsightItem({required this.insight});

  final MarketInsight insight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final insightColor = _getInsightColor(insight.type);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: insightColor, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getInsightIcon(insight.type), size: 20, color: insightColor),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(insight.title, style: theme.textTheme.titleMedium)),
              ],
            ),
            if (insight.description != insight.title) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(insight.description, style: theme.textTheme.bodyMedium),
            ],
            if (insight.affectedTokens != null && insight.affectedTokens!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children:
                    insight.affectedTokens!
                        .map(
                          (token) => Chip(
                            label: Text(token, style: theme.textTheme.labelSmall),
                            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
              ),
            ],
            if (insight.impact != null && insight.impact!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.assessment_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        'Impact: ${insight.impact}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
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

  IconData _getInsightIcon(InsightType type) {
    switch (type) {
      case InsightType.trend:
        return Icons.trending_up;
      case InsightType.opportunity:
        return Icons.star_outline;
      case InsightType.warning:
        return Icons.warning_amber;
      case InsightType.news:
        return Icons.newspaper;
    }
  }

  Color _getInsightColor(InsightType type) {
    switch (type) {
      case InsightType.trend:
        return Colors.blue;
      case InsightType.opportunity:
        return Colors.green;
      case InsightType.warning:
        return Colors.orange;
      case InsightType.news:
        return Colors.purple;
    }
  }
}
