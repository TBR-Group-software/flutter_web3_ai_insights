import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/providers/ai_insights_providers.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class AiInsightsErrorView extends ConsumerWidget {
  const AiInsightsErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
              const SizedBox(height: AppSpacing.md),
              Text(l10n.errorSomethingWrong, style: theme.textTheme.titleMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: () => ref.read(aiInsightsProvider.notifier).generateAnalysis(),
                icon: const Icon(Icons.refresh),
                label: Text(l10n.tryAgain),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
