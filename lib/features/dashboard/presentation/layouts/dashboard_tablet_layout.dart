import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/portfolio_summary_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/market_overview_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/recent_transactions_card.dart';
import 'package:web3_ai_assistant/features/dashboard/presentation/widgets/ai_insights_preview_card.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PortfolioSummaryCard(),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: MarketOverviewCard(),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: RecentTransactionsCard(),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: AiInsightsPreviewCard(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
