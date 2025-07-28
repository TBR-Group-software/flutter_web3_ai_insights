import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/investment_recommendation.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority});

  final RecommendationPriority priority;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getPriorityColor(priority);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(12)),
      child: Text(
        _getPriorityLabel(context, priority),
        style: theme.textTheme.labelSmall?.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getPriorityColor(RecommendationPriority priority) {
    switch (priority) {
      case RecommendationPriority.high:
        return Colors.red;
      case RecommendationPriority.medium:
        return Colors.orange;
      case RecommendationPriority.low:
        return Colors.green;
    }
  }

  String _getPriorityLabel(BuildContext context, RecommendationPriority priority) {
    final l10n = AppLocalizations.of(context)!;
    switch (priority) {
      case RecommendationPriority.high:
        return l10n.priorityHigh;
      case RecommendationPriority.medium:
        return l10n.priorityMedium;
      case RecommendationPriority.low:
        return l10n.priorityLow;
    }
  }
}
