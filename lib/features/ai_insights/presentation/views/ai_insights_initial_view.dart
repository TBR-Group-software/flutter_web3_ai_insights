import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/generate_report_button.dart';
import 'package:web3_ai_assistant/features/ai_insights/providers/ai_insights_providers.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class AiInsightsInitialView extends ConsumerWidget {
  const AiInsightsInitialView({super.key, required this.canGenerate});

  final bool canGenerate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome_rounded, size: 80, color: theme.colorScheme.primary),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.navigationAiInsights, style: theme.textTheme.headlineMedium),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.aiDescription,
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
                    Text(l10n.aiRequirements, style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.aiRequirement1),
                    Text(l10n.aiRequirement2),
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
