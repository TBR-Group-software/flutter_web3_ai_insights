import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/utils/date_formatter.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';

class AiInsightsHistoryBar extends StatelessWidget {
  const AiInsightsHistoryBar({
    super.key,
    required this.history,
    required this.currentIndex,
    required this.onNavigatePrevious,
    required this.onNavigateNext,
    required this.onSelectIndex,
  });

  final List<PortfolioAnalysis> history;
  final int currentIndex;
  final VoidCallback onNavigatePrevious;
  final VoidCallback onNavigateNext;
  final ValueChanged<int> onSelectIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentAnalysis = history[currentIndex];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            // Previous button
            IconButton(
              onPressed: currentIndex > 0 ? onNavigatePrevious : null,
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Previous report',
            ),
            
            // Report info and dropdown
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Report ${currentIndex + 1} of ${history.length}',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    DateFormatter.formatGeneratedRelativeTime(currentAnalysis.generatedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            // Quick access dropdown
            PopupMenuButton<int>(
              onSelected: onSelectIndex,
              itemBuilder: (context) => List.generate(
                history.length,
                (index) => PopupMenuItem(
                  value: index,
                  child: Row(
                    children: [
                      if (index == currentIndex)
                        Icon(
                          Icons.check,
                          size: 16,
                          color: theme.colorScheme.primary,
                        )
                      else
                        const SizedBox(width: 16),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Report ${index + 1}',
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              DateFormatter.formatDateTime(history[index].generatedAt),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'History',
                    style: theme.textTheme.labelLarge,
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            
            // Next button
            IconButton(
              onPressed: currentIndex < history.length - 1 ? onNavigateNext : null,
              icon: const Icon(Icons.chevron_right),
              tooltip: 'Next report',
            ),
          ],
        ),
      ),
    );
  }

}
