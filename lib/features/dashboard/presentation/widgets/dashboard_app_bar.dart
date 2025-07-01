import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/connected_wallet_chip.dart';

class DashboardAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final walletState = ref.watch(walletConnectionStateProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = AppBreakpoints.isMobile(constraints.maxWidth);

        return AppBar(
          title: Row(
            children: [
              if (!isMobile) ...[
                Icon(
                  Icons.dashboard_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                AppConstants.dashboardLabel,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
          actions: [
            // Test buttons (remove in production)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                ref.read(dashboardLoadingProvider.notifier).state = true;
                await Future.delayed(const Duration(seconds: 2));
                ref.read(dashboardLoadingProvider.notifier).state = false;
              },
              tooltip: 'Test Loading State',
            ),
            IconButton(
              icon: Icon(
                walletState.isConnected ? Icons.link_off : Icons.link,
              ),
              onPressed: () {
                final currentState = ref.read(walletConnectionStateProvider);
                ref.read(walletConnectionStateProvider.notifier).state = 
                  currentState.isConnected 
                    ? WalletConnectionState.disconnected 
                    : WalletConnectionState.connected;
              },
              tooltip: walletState.isConnected ? 'Disconnect Wallet' : 'Connect Wallet',
            ),
            // Wallet status widget
            if (walletState.isConnected)
              ConnectedWalletChip(
                onTap: () => context.goNamed(AppConstants.walletRouteName),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.md,
                ),
                child: FilledButton.icon(
                  onPressed: () => context.goNamed(AppConstants.walletRouteName),
                  icon: const Icon(Icons.account_balance_wallet, size: 18),
                  label: Text(isMobile ? 'Connect' : 'Connect Wallet'),
                  style: FilledButton.styleFrom(
                    minimumSize: Size(isMobile ? 100 : 140, 40),
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? AppSpacing.sm : AppSpacing.md,
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

