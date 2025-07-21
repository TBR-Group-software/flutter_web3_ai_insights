import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_padding.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/widgets/wallet_info_card.dart';
import 'package:web3_ai_assistant/features/wallet/providers/wallet_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final walletState = ref.watch(walletNotifierProvider);
    
    return AdaptiveScaffold(
      currentRoute: AppConstants.walletRoute,
      title: AppConstants.walletLabel,
      body: ResponsivePadding.all(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: walletState.when(
              data: (state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    Icon(
                      state.isConnected
                          ? Icons.account_balance_wallet_rounded
                          : Icons.account_balance_wallet_outlined,
                      size: 80,
                      color: state.isConnected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Title
                    Text(
                      state.isConnected ? 'Wallet Connected' : 'Connect Your Wallet',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    
                    // Error message
                    if (state.error != null) ...[
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          state.error!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                    
                    // Connected info
                    if (state.isConnected && state.walletInfo != null) ...[
                      // Address
                      WalletInfoCard(
                        title: 'Address',
                        value: state.walletInfo!.shortAddress,
                        fullValue: state.walletInfo!.address,
                        onCopy: () => _copyToClipboard(context, state.walletInfo!.address),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      // Balance
                      WalletInfoCard(
                        title: 'Balance',
                        value: state.walletInfo!.formattedBalance,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      // Network
                      if (state.walletInfo!.networkName != null)
                        WalletInfoCard(
                          title: 'Network',
                          value: state.walletInfo!.networkName!,
                        ),
                    ],
                    
                    const SizedBox(height: AppSpacing.xxl),
                    
                    // Connect button
                    if (!state.isConnected)
                      FilledButton.icon(
                        onPressed: state.isLoading
                            ? null
                            : () async {
                                await ref.read(walletNotifierProvider.notifier).connect();
                              },
                        icon: state.isLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              )
                            : const Icon(Icons.link_rounded),
                        label: Text(state.isLoading ? 'Connecting...' : 'Connect MetaMask'),
                      ),
                  ],
                );
              },
              loading: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Loading wallet...',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              error: (error, _) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 80,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Error',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    error.toString(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  FilledButton.icon(
                    onPressed: () async {
                      await ref.read(walletNotifierProvider.notifier).connect();
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address copied to clipboard'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        width: 280,
      ),
    );
  }
}
