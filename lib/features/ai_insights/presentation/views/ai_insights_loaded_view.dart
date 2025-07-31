import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/analysis_card.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/ai_insights_history_bar.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/market_insights_list.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/recommendations_list.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/risk_meter.dart';
import 'package:web3_ai_assistant/features/ai_insights/providers/ai_insights_providers.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class AiInsightsLoadedView extends ConsumerWidget {
  const AiInsightsLoadedView({
    super.key,
    required this.history,
    required this.currentIndex,
  });

  final List<PortfolioAnalysis> history;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final analysis = history[currentIndex];
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // History navigation bar
          AiInsightsHistoryBar(
            history: history,
            currentIndex: currentIndex,
            onNavigatePrevious: () => 
              ref.read(aiInsightsProvider.notifier).navigatePrevious(),
            onNavigateNext: () => 
              ref.read(aiInsightsProvider.notifier).navigateNext(),
            onSelectIndex: (index) => 
              ref.read(aiInsightsProvider.notifier).navigateToAnalysis(index),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Generate new report button
          Center(
            child: FilledButton.icon(
              onPressed: () => ref.read(aiInsightsProvider.notifier).generateAnalysis(),
              icon: const Icon(Icons.auto_awesome),
              label: Text(l10n.aiGenerateNewReport),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Analysis content
          AnalysisCard(analysis: analysis),
          const SizedBox(height: AppSpacing.lg),
          RiskMeter(riskAssessment: analysis.riskAssessment),
          const SizedBox(height: AppSpacing.lg),
          RecommendationsList(recommendations: analysis.recommendations),
          const SizedBox(height: AppSpacing.lg),
          MarketInsightsList(insights: analysis.marketInsights),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
