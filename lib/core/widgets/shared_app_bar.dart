import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/connected_wallet_chip.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class SharedAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SharedAppBar({
    super.key,
    required this.title,
    this.showIcon = true,
    this.icon,
    this.actions,
  });

  final String title;
  final bool showIcon;
  final IconData? icon;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final walletState = ref.watch(walletNotifierProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = AppBreakpoints.isMobile(constraints.maxWidth);

        return AppBar(
          title: Row(
            children: [
              if (!isMobile && showIcon && icon != null) ...[
                Icon(
                  icon,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                title,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
          actions: [
            // Custom actions if provided
            if (actions != null) ...actions!,
            
            // Wallet connection UI
            walletState.when(
              data: (state) {
                if (state.isConnected && state.walletInfo != null) {
                  return ConnectedWalletChip(
                    address: state.walletInfo!.address,
                    onDisconnect: () async {
                      await ref.read(walletNotifierProvider.notifier).disconnect();
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                      horizontal: AppSpacing.md,
                    ),
                    child: FilledButton.icon(
                      onPressed: state.isLoading
                          ? null
                          : () => context.goNamed(AppConstants.walletRouteName),
                      icon: state.isLoading
                          ? SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : const Icon(Icons.account_balance_wallet, size: 18),
                      label: Text(
                        state.isLoading
                            ? 'Connecting...'
                            : (isMobile ? 'Connect' : 'Connect Wallet'),
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: Size(isMobile ? 100 : 140, 40),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? AppSpacing.sm : AppSpacing.md,
                        ),
                      ),
                    ),
                  );
                }
              },
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.md,
                ),
                child: FilledButton.icon(
                  onPressed: () => context.goNamed(AppConstants.walletRouteName),
                  icon: const Icon(Icons.error_outline, size: 18),
                  label: const Text('Wallet Error'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
