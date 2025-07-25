import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/analysis_section.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({super.key, required this.analysis});

  final PortfolioAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.analytics_outlined, color: theme.colorScheme.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Portfolio Analysis', style: theme.textTheme.headlineSmall),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Generated ${_formatDateTime(analysis.generatedAt)}',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnalysisSection(
                  title: 'Overview',
                  content: analysis.overview,
                  icon: Icons.summarize_outlined,
                ),
                const SizedBox(height: AppSpacing.xl),
                AnalysisSection(
                  title: 'Performance Summary',
                  content: analysis.performanceSummary,
                  icon: Icons.trending_up_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
