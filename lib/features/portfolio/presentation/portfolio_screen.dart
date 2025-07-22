import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_padding.dart';
import 'package:web3_ai_assistant/features/portfolio/providers/portfolio_providers.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_card.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/error_state_widget.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_content_widget.dart';
import 'package:web3_ai_assistant/core/providers/repository_providers.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletState = ref.watch(walletRepositoryProvider).currentWalletState;
    
    return AdaptiveScaffold(
      currentRoute: AppConstants.portfolioRoute,
      title: AppConstants.portfolioLabel,
      body: ResponsivePadding.all(
        child: walletState.isConnected 
            ? const _ConnectedPortfolioView()
            : const _DisconnectedPortfolioView(),
      ),
    );
  }
}

class _ConnectedPortfolioView extends ConsumerWidget {
  const _ConnectedPortfolioView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioStream = ref.watch(portfolioStreamProvider);
    
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(portfolioNotifierProvider.notifier).refreshPortfolio();
      },
      child: portfolioStream.when(
        loading: () => const _LoadingState(),
        error: (error, stackTrace) => ErrorStateWidget(
          error: error.toString(),
          onRetry: () => ref.refresh(portfolioStreamProvider),
        ),
        data: (tokens) => tokens.isEmpty
            ? const _EmptyPortfolioState()
            : PortfolioContentWidget(tokens: tokens),
      ),
    );
  }
}

class _DisconnectedPortfolioView extends StatelessWidget {
  const _DisconnectedPortfolioView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pie_chart_rounded,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Your Portfolio',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Connect your wallet to view your token holdings',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 48,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No wallet connected',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  FilledButton(
                    onPressed: () => context.goNamed(AppConstants.walletRouteName),
                    child: const Text('Connect Wallet'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PortfolioSummaryCard(
            tokens: [],
            isLoading: true,
          ),
          const SizedBox(height: AppSpacing.md),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                title: Container(
                  width: 100,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                subtitle: Container(
                  width: 150,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                trailing: Container(
                  width: 80,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _EmptyPortfolioState extends StatelessWidget {
  const _EmptyPortfolioState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No Tokens Found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            "Your wallet doesn't contain any supported tokens yet",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
