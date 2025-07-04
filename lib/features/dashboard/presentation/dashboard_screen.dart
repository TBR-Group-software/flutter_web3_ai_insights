import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_builder.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_padding.dart';
import 'package:web3_ai_assistant/core/widgets/shared_app_bar.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/providers/dashboard_providers.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/layouts/dashboard_mobile_layout.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/layouts/dashboard_tablet_layout.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/layouts/dashboard_desktop_layout.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/layouts/dashboard_loading_layout.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(dashboardLoadingProvider);
    
    return Scaffold(
      appBar: const SharedAppBar(
        title: AppConstants.dashboardLabel,
        icon: Icons.dashboard_rounded,
      ),
      body: AdaptiveScaffold(
        currentRoute: AppConstants.dashboardRoute,
        body: isLoading
            ? const ResponsiveContainer(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.lg),
                  child: DashboardLoadingLayout(),
                ),
              )
            : ResponsiveContainer(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: ResponsiveBuilder(
                    mobile: (context, constraints) => const DashboardMobileLayout(),
                    tablet: (context, constraints) => const DashboardTabletLayout(),
                    desktop: (context, constraints) => const DashboardDesktopLayout(),
                  ),
                ),
              ),
      ),
    );
  }
}
