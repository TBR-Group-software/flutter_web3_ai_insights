import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/loading_skeleton.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_header.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_stats_row.dart';

class PortfolioSummaryCardTablet extends StatelessWidget {
  const PortfolioSummaryCardTablet({
    super.key,
    required this.tokens,
    this.isLoading = false,
  });

  final List<PortfolioToken> tokens;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: isLoading
            ? const LoadingSkeletonSummaryCard()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PortfolioSummaryHeader(),
                  const SizedBox(height: AppSpacing.lg),
                  PortfolioStatsRow(tokens: tokens),
                ],
              ),
      ),
    );
  }

}

class LoadingSkeletonSummaryCard extends StatelessWidget {
  const LoadingSkeletonSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            LoadingSkeleton(width: 28, height: 28),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: LoadingSkeleton(width: 200, height: 24),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(child: LoadingSkeleton(width: double.infinity, height: 60)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: LoadingSkeleton(width: double.infinity, height: 60)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: LoadingSkeleton(width: double.infinity, height: 60)),
          ],
        ),
      ],
    );
  }
} 
