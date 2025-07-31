import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/constants/app_constants.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_padding.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/views/ai_insights_error_view.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/views/ai_insights_initial_view.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/views/ai_insights_loaded_view.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/views/ai_insights_loading_view.dart';
import 'package:web3_ai_assistant/features/ai_insights/providers/ai_insights_providers.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class AiInsightsScreen extends ConsumerWidget {
  const AiInsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final aiStateAsync = ref.watch(aiInsightsProvider);
    final canGenerate = ref.watch(canGenerateAnalysisProvider);

    return AdaptiveScaffold(
      currentRoute: AppConstants.aiInsightsRoute,
      title: l10n.navigationAiInsights,
      body: ResponsivePadding.all(
        child: aiStateAsync.when(
          data: (aiState) => switch (aiState) {
            AiInsightsInitial() => AiInsightsInitialView(canGenerate: canGenerate),
            AiInsightsLoading() => const AiInsightsLoadingView(),
            AiInsightsWithHistory(:final history, :final currentIndex) => 
              AiInsightsLoadedView(history: history, currentIndex: currentIndex),
            AiInsightsError(:final message) => AiInsightsErrorView(message: message),
          },
          loading: () => const AiInsightsLoadingView(),
          error: (error, _) => AiInsightsErrorView(message: error.toString()),
        ),
      ),
    );
  }
}
