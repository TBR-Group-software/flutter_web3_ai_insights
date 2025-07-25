import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_status_icon.dart';

enum WalletStatusType { connected, disconnected, loading, error }

class WalletStatusWidget extends StatelessWidget {
  const WalletStatusWidget({super.key, required this.type, this.message, this.networkName});

  final WalletStatusType type;
  final String? message;
  final String? networkName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: _getBackgroundColor(theme), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WalletStatusIcon(type: type),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              _getMessage(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _getTextColor(theme),
                fontWeight: type == WalletStatusType.connected ? FontWeight.w500 : null,
              ),
              maxLines: type == WalletStatusType.error ? 2 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(ThemeData theme) {
    switch (type) {
      case WalletStatusType.connected:
      case WalletStatusType.loading:
        return theme.colorScheme.primaryContainer;
      case WalletStatusType.disconnected:
        return theme.colorScheme.surfaceContainerHighest;
      case WalletStatusType.error:
        return theme.colorScheme.errorContainer;
    }
  }

  Color _getTextColor(ThemeData theme) {
    switch (type) {
      case WalletStatusType.connected:
      case WalletStatusType.loading:
        return theme.colorScheme.onPrimaryContainer;
      case WalletStatusType.disconnected:
        return theme.colorScheme.onSurfaceVariant;
      case WalletStatusType.error:
        return theme.colorScheme.onErrorContainer;
    }
  }

  String _getMessage() {
    switch (type) {
      case WalletStatusType.connected:
        return 'Connected to ${networkName ?? 'Unknown Network'}';
      case WalletStatusType.disconnected:
        return 'Wallet not connected';
      case WalletStatusType.loading:
        return 'Connecting...';
      case WalletStatusType.error:
        return message ?? 'Connection error';
    }
  }
}
