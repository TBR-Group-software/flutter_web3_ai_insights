import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';

class TransactionItem extends StatelessWidget {

  const TransactionItem({
    super.key,
    required this.transaction,
  });
  final MockTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    IconData getIcon() {
      switch (transaction.type) {
        case 'Received':
          return Icons.arrow_downward_rounded;
        case 'Sent':
          return Icons.arrow_upward_rounded;
        case 'Swap':
          return Icons.swap_horiz_rounded;
        default:
          return Icons.circle;
      }
    }

    Color getColor() {
      switch (transaction.type) {
        case 'Received':
          return theme.colorScheme.tertiary;
        case 'Sent':
          return theme.colorScheme.error;
        case 'Swap':
          return theme.colorScheme.primary;
        default:
          return theme.colorScheme.onSurfaceVariant;
      }
    }

    Color getBackgroundColor() {
      switch (transaction.type) {
        case 'Received':
          return theme.colorScheme.tertiaryContainer;
        case 'Sent':
          return theme.colorScheme.errorContainer;
        case 'Swap':
          return theme.colorScheme.primaryContainer;
        default:
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
            decoration: BoxDecoration(
              color: getBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              getIcon(),
              color: getColor(),
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.amount,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  transaction.time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (transaction.status == TransactionStatus.pending)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
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
            Icon(
              Icons.check_circle,
              color: theme.colorScheme.tertiary,
              size: 20,
            ),
        ],
      ),
    );
  }
} 
