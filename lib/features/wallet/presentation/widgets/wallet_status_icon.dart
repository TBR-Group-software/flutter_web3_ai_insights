import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_status_widget.dart';

class WalletStatusIcon extends StatelessWidget {
  const WalletStatusIcon({
    super.key,
    required this.status,
    this.size = 24.0,
  });

  final WalletStatusType status;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: status == WalletStatusType.connected
            ? theme.colorScheme.primary.withAlpha(51) // 20% opacity
            : theme.colorScheme.onSurfaceVariant.withAlpha(51), // 20% opacity
      ),
      child: Icon(
        status == WalletStatusType.connected
            ? Icons.check_circle
            : Icons.cancel,
        size: size * 0.7,
        color: status == WalletStatusType.connected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
