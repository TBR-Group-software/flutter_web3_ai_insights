import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/widgets/shared_app_bar.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class AdaptiveScaffoldDesktopLayout extends ConsumerWidget {
  const AdaptiveScaffoldDesktopLayout({
    super.key,
    required this.currentRoute,
    required this.body,
    this.title,
    this.actions,
  });
  final String currentRoute;
  final Widget body;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = _getCurrentIndex();

    // Update navigation state when route changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedNavigationIndexProvider.notifier).state = currentIndex;
    });

    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => _onNavigate(context, index),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(l10n.appName, style: theme.textTheme.titleSmall),
              ),
              NavigationDrawerDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard_rounded),
                label: Text(l10n.navigationDashboard),
              ),
              NavigationDrawerDestination(
                icon: const Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: const Icon(Icons.account_balance_wallet_rounded),
                label: Text(l10n.navigationWallet),
              ),
              NavigationDrawerDestination(
                icon: const Icon(Icons.pie_chart_outline),
                selectedIcon: const Icon(Icons.pie_chart_rounded),
                label: Text(l10n.navigationPortfolio),
              ),
              NavigationDrawerDestination(
                icon: const Icon(Icons.auto_awesome_outlined),
                selectedIcon: const Icon(Icons.auto_awesome_rounded),
                label: Text(l10n.navigationAiInsights),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                if (title != null) SharedAppBar(title: title!, icon: _getIconForRoute(currentRoute), actions: actions),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getCurrentIndex() {
    switch (currentRoute) {
      case AppConstants.dashboardRoute:
        return 0;
      case AppConstants.walletRoute:
        return 1;
      case AppConstants.portfolioRoute:
        return 2;
      case AppConstants.aiInsightsRoute:
        return 3;
      default:
        return 0;
    }
  }

  void _onNavigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppConstants.dashboardRoute);
      case 1:
        context.go(AppConstants.walletRoute);
      case 2:
        context.go(AppConstants.portfolioRoute);
      case 3:
        context.go(AppConstants.aiInsightsRoute);
    }
  }

  IconData? _getIconForRoute(String route) {
    switch (route) {
      case AppConstants.dashboardRoute:
        return Icons.dashboard_rounded;
      case AppConstants.walletRoute:
        return Icons.account_balance_wallet_rounded;
      case AppConstants.portfolioRoute:
        return Icons.pie_chart_rounded;
      case AppConstants.aiInsightsRoute:
        return Icons.auto_awesome_rounded;
      default:
        return null;
    }
  }
}
