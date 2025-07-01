import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_padding.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_builder.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AdaptiveScaffold(
      currentRoute: AppConstants.dashboardRoute,
      title: AppConstants.dashboardLabel,
      body: ResponsivePadding.all(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.dashboard_rounded,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Welcome to ${AppConstants.appName}',
                style: theme.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Your Web3 Portfolio Analysis Hub',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Navigation buttons for testing
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () => context.goNamed(AppConstants.walletRouteName),
                    icon: const Icon(Icons.account_balance_wallet),
                    label: const Text('Connect Wallet'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.goNamed(AppConstants.portfolioRouteName),
                    icon: const Icon(Icons.pie_chart),
                    label: const Text('View Portfolio'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.goNamed(AppConstants.aiInsightsRouteName),
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('AI Insights'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
              // Test responsive layout
              ResponsiveBuilder(
                mobile: (context, constraints) => Column(
                  children: [
                    _buildInfoCard(context, 'Mobile Layout', Icons.phone_android),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Width: ${constraints.maxWidth.toStringAsFixed(0)}px',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                tablet: (context, constraints) => Column(
                  children: [
                    _buildInfoCard(context, 'Tablet Layout', Icons.tablet),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Width: ${constraints.maxWidth.toStringAsFixed(0)}px',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                desktop: (context, constraints) => Column(
                  children: [
                    _buildInfoCard(context, 'Desktop Layout', Icons.computer),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Width: ${constraints.maxWidth.toStringAsFixed(0)}px',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Text(title, style: theme.textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}