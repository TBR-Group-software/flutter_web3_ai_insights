import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_info_row.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class WalletAddressDisplay extends ConsumerStatefulWidget {
  const WalletAddressDisplay({super.key});

  @override
  ConsumerState<WalletAddressDisplay> createState() => _WalletAddressDisplayState();
}

class _WalletAddressDisplayState extends ConsumerState<WalletAddressDisplay> {
  bool _isCopied = false;

  Future<void> _copyAddress(String address) async {
    await Clipboard.setData(ClipboardData(text: address));
    setState(() => _isCopied = true);
    
    // Reset copied state after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isCopied = false);
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Address copied to clipboard'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: 280,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletNotifierProvider);
    final theme = Theme.of(context);

    return walletState.maybeWhen(
      data: (state) {
        if (!state.isConnected || state.walletInfo == null) {
          return const SizedBox.shrink();
        }

        final walletInfo = state.walletInfo!;

        return Card(
          elevation: 0,
          color: theme.colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Wallet Details',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                
                // Address section
                WalletInfoRow(
                  label: 'Address',
                  value: walletInfo.shortAddress,
                  fullValue: walletInfo.address,
                  onCopy: () => _copyAddress(walletInfo.address),
                  isCopied: _isCopied,
                ),
                
                const SizedBox(height: AppSpacing.md),
                
                // Balance section
                if (walletInfo.balance != null) ...[
                  WalletInfoRow(
                    label: 'Balance',
                    value: walletInfo.formattedBalance,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                
                // Network section
                if (walletInfo.networkName != null) ...[
                  WalletInfoRow(
                    label: 'Network',
                    value: walletInfo.networkName!,
                  ),
                ],
              ],
            ),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

}
