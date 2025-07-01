import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/dashboard_screen.dart';
import 'package:web3_ai_assistant/features/wallet/presentation/wallet_screen.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/portfolio_screen.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/ai_insights_screen.dart';

/// Main router configuration for the application
class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: AppConstants.dashboardRoute,
      routes: [
        GoRoute(
          path: AppConstants.dashboardRoute,
          name: AppConstants.dashboardRouteName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const DashboardScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: AppConstants.walletRoute,
          name: AppConstants.walletRouteName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const WalletScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: AppConstants.portfolioRoute,
          name: AppConstants.portfolioRouteName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PortfolioScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
        GoRoute(
          path: AppConstants.aiInsightsRoute,
          name: AppConstants.aiInsightsRouteName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AiInsightsScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        ),
      ],
      errorPageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  state.error?.toString() ?? 'Unknown error',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go(AppConstants.dashboardRoute),
                  child: const Text('Go to Dashboard'),
                ),
              ],
            ),
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}