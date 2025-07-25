import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/core/widgets/markdown_text.dart';

class AnalysisSection extends StatelessWidget {
  const AnalysisSection({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  final String title;
  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.xs),
            Text(title, style: theme.textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        MarkdownText(data: content, selectable: true),
      ],
    );
  }
}
