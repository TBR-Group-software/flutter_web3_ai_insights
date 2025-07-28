import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/transaction/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transaction});
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    IconData getIcon() {
      switch (transaction.type) {
        case TransactionType.received:
          return Icons.arrow_downward_rounded;
        case TransactionType.sent:
          return Icons.arrow_upward_rounded;
        case TransactionType.swap:
          return Icons.swap_horiz_rounded;
        case TransactionType.contract:
          return Icons.code_rounded;
        case TransactionType.unknown:
          return Icons.circle;
      }
    }

    Color getColor() {
      switch (transaction.type) {
        case TransactionType.received:
          return theme.colorScheme.tertiary;
        case TransactionType.sent:
          return theme.colorScheme.error;
        case TransactionType.swap:
          return theme.colorScheme.primary;
        case TransactionType.contract:
          return theme.colorScheme.secondary;
        case TransactionType.unknown:
          return theme.colorScheme.onSurfaceVariant;
      }
    }

    Color getBackgroundColor() {
      switch (transaction.type) {
        case TransactionType.received:
          return theme.colorScheme.tertiaryContainer;
        case TransactionType.sent:
          return theme.colorScheme.errorContainer;
        case TransactionType.swap:
          return theme.colorScheme.primaryContainer;
        case TransactionType.contract:
          return theme.colorScheme.secondaryContainer;
        case TransactionType.unknown:
          return theme.colorScheme.surfaceContainer;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: getBackgroundColor(), borderRadius: BorderRadius.circular(12)),
            child: Icon(getIcon(), color: getColor(), size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.displayAmount, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                Text(
                  transaction.timeAgo,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (transaction.status == TransactionStatus.pending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Pending',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (transaction.status == TransactionStatus.completed)
            Icon(Icons.check_circle, color: theme.colorScheme.tertiary, size: 20),
        ],
      ),
    );
  }
}
