import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';

class ConnectedWalletChip extends StatelessWidget {
  const ConnectedWalletChip({
    super.key,
    required this.address,
    required this.onDisconnect,
  });

  final String address;
  final VoidCallback onDisconnect;

  String _formatAddress(String address, bool isMobile) {
    if (address.length < 42) {
      return address;
    }
    if (isMobile) {
      return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
    } else {
      return '${address.substring(0, 10)}...${address.substring(address.length - 8)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = AppBreakpoints.isMobile(MediaQuery.of(context).size.width);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: PopupMenuButton<String>(
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<String>(
            value: 'view',
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text('View Wallet'),
              ],
            ),
          ),
          PopupMenuItem<String>(
            value: 'copy',
            child: Row(
              children: [
                Icon(
                  Icons.copy,
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text('Copy Address'),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem<String>(
            value: 'disconnect',
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  size: 20,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Disconnect',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],
            ),
          ),
        ],
        onSelected: (String value) {
          switch (value) {
            case 'view':
              context.goNamed(AppConstants.walletRouteName);
            case 'copy':
              Clipboard.setData(ClipboardData(text: address));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address copied to clipboard'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  width: 280,
                ),
              );
            case 'disconnect':
              onDisconnect();
          }
        },
        child: Material(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    _formatAddress(address, isMobile),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Icon(
                    Icons.expand_more,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 
