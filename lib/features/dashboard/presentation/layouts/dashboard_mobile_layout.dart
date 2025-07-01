import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/portfolio_summary_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/market_overview_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/recent_transactions_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/ai_insights_preview_card.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PortfolioSummaryCard(),
        SizedBox(height: AppSpacing.md),
        MarketOverviewCard(),
        SizedBox(height: AppSpacing.md),
        RecentTransactionsCard(),
        SizedBox(height: AppSpacing.md),
        AiInsightsPreviewCard(),
      ],
    );
  }
}
