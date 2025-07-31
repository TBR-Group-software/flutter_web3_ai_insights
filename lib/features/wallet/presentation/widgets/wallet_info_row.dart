import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

class WalletInfoRow extends StatelessWidget {
  const WalletInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.fullValue,
    this.onCopy,
    this.isCopied = false,
  });

  final String label;
  final String value;
  final String? fullValue;
  final VoidCallback? onCopy;
  final bool isCopied;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: fullValue ?? value,
              child: Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontFamily: 'monospace'),
              ),
            ),
            if (onCopy != null) ...[
              const SizedBox(width: AppSpacing.xs),
              IconButton(
                onPressed: onCopy,
                icon: Icon(isCopied ? Icons.check_rounded : Icons.copy_rounded, size: 16),
                tooltip: isCopied ? 'Copied!' : 'Copy address',
                padding: const EdgeInsets.all(AppSpacing.xs),
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                color: isCopied ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
