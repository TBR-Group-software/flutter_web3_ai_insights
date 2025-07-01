import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/loading_skeleton.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_builder.dart';

class DashboardLoadingLayout extends StatelessWidget {
  const DashboardLoadingLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (context, constraints) => const _MobileLoadingLayout(),
      tablet: (context, constraints) => const _TabletLoadingLayout(),
      desktop: (context, constraints) => const _DesktopLoadingLayout(),
    );
  }
}

class _MobileLoadingLayout extends StatelessWidget {
  const _MobileLoadingLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LoadingSkeleton.card(height: 180),
        const SizedBox(height: AppSpacing.md),
        LoadingSkeleton.card(height: 200),
        const SizedBox(height: AppSpacing.md),
        LoadingSkeleton.card(height: 250),
        const SizedBox(height: AppSpacing.md),
        LoadingSkeleton.card(height: 220),
      ],
    );
  }
}

class _TabletLoadingLayout extends StatelessWidget {
  const _TabletLoadingLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: LoadingSkeleton.card(height: 180)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: LoadingSkeleton.card(height: 180)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: LoadingSkeleton.card(height: 250)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: LoadingSkeleton.card(height: 250)),
          ],
        ),
      ],
    );
  }
}

class _DesktopLoadingLayout extends StatelessWidget {
  const _DesktopLoadingLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: LoadingSkeleton.card(height: 180),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 3,
              child: LoadingSkeleton.card(height: 180),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: LoadingSkeleton.card(height: 250)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: LoadingSkeleton.card(height: 250)),
          ],
        ),
      ],
    );
  }
}