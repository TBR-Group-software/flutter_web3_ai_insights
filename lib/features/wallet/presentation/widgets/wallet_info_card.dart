import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

class WalletInfoCard extends StatelessWidget {
  const WalletInfoCard({
    super.key,
    required this.title,
    required this.value,
    this.fullValue,
    this.onCopy,
  });

  final String title;
  final String value;
  final String? fullValue;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: Tooltip(
                  message: fullValue ?? value,
                  child: Text(
                    value,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (onCopy != null) ...[
                const SizedBox(width: AppSpacing.sm),
                IconButton(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  tooltip: 'Copy',
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  padding: EdgeInsets.zero,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
