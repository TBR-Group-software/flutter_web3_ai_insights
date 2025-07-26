import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_status_widget.dart';

class WalletStatusIcon extends StatelessWidget {
  const WalletStatusIcon({super.key, required this.type});

  final WalletStatusType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    switch (type) {
      case WalletStatusType.connected:
        return Icon(Icons.check_circle_rounded, color: theme.colorScheme.onPrimaryContainer, size: 20);
      case WalletStatusType.disconnected:
        return Icon(Icons.account_balance_wallet_outlined, color: theme.colorScheme.onSurfaceVariant, size: 20);
      case WalletStatusType.loading:
        return SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2, color: theme.colorScheme.onPrimaryContainer),
        );
      case WalletStatusType.error:
        return Icon(Icons.error_outline_rounded, color: theme.colorScheme.onErrorContainer, size: 20);
    }
  }
}
