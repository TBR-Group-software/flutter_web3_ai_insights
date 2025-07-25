import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/generate_report_button.dart';
import 'package:web3_ai_assistant/features/ai_insights/providers/ai_insights_providers.dart';

class AiInsightsInitialView extends ConsumerWidget {
  const AiInsightsInitialView({super.key, required this.canGenerate});

  final bool canGenerate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: AppSpacing.xl),
          Text('AI Portfolio Analysis', style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Get AI-powered insights for your Web3 portfolio',
            style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!canGenerate) ...[
                    Icon(Icons.info_outline, size: 48, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(height: AppSpacing.md),
                    Text('Portfolio analysis requires:', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.sm),
                    const Text('1. Connected wallet'),
                    const Text('2. Token holdings data'),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  GenerateReportButton(
                    onPressed: canGenerate ? () => ref.read(aiInsightsProvider.notifier).generateAnalysis() : null,
                    isEnabled: canGenerate,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
