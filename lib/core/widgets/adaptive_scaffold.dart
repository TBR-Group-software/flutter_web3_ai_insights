import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';

/// An adaptive scaffold that changes navigation style based on screen size
class AdaptiveScaffold extends StatelessWidget {

  const AdaptiveScaffold({
    super.key,
    required this.body,
    this.currentRoute,
    this.title,
    this.actions,
  });
  final Widget body;
  final String? currentRoute;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final navigationType = AppBreakpoints.getNavigationType(width);

        switch (navigationType) {
          case NavigationType.bottom:
            return _buildMobileLayout(context);
          case NavigationType.rail:
            return _buildTabletLayout(context);
          case NavigationType.drawer:
            return _buildDesktopLayout(context);
        }
      },
    );
  }

  // Mobile layout with bottom navigation
  Widget _buildMobileLayout(BuildContext context) {
    final currentIndex = _getCurrentIndex();

    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              actions: actions,
            )
          : null,
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _onNavigate(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: AppConstants.dashboardLabel,
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet_rounded),
            label: AppConstants.walletLabel,
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            selectedIcon: Icon(Icons.pie_chart_rounded),
            label: AppConstants.portfolioLabel,
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome_rounded),
            label: AppConstants.aiInsightsLabel,
          ),
        ],
      ),
    );
  }

  // Tablet layout with navigation rail
  Widget _buildTabletLayout(BuildContext context) {
    final currentIndex = _getCurrentIndex();

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => _onNavigate(context, index),
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard_rounded),
                label: Text(AppConstants.dashboardLabel),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: Text(AppConstants.walletLabel),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pie_chart_outline),
                selectedIcon: Icon(Icons.pie_chart_rounded),
                label: Text(AppConstants.portfolioLabel),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.auto_awesome_outlined),
                selectedIcon: Icon(Icons.auto_awesome_rounded),
                label: Text(AppConstants.aiInsightsLabel),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                if (title != null)
                  AppBar(
                    title: Text(title!),
                    actions: actions,
                    automaticallyImplyLeading: false,
                  ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Desktop layout with navigation drawer
  Widget _buildDesktopLayout(BuildContext context) {
    final theme = Theme.of(context);
    final currentIndex = _getCurrentIndex();

    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) => _onNavigate(context, index),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  AppConstants.appName,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard_rounded),
                label: Text(AppConstants.dashboardLabel),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet_rounded),
                label: Text(AppConstants.walletLabel),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.pie_chart_outline),
                selectedIcon: Icon(Icons.pie_chart_rounded),
                label: Text(AppConstants.portfolioLabel),
              ),
              const NavigationDrawerDestination(
                icon: Icon(Icons.auto_awesome_outlined),
                selectedIcon: Icon(Icons.auto_awesome_rounded),
                label: Text(AppConstants.aiInsightsLabel),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                if (title != null)
                  AppBar(
                    title: Text(title!),
                    actions: actions,
                    automaticallyImplyLeading: false,
                  ),
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
}
