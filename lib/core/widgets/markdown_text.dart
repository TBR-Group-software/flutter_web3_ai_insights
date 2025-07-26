import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

class MarkdownText extends StatelessWidget {
  const MarkdownText({
    super.key,
    required this.data,
    this.selectable = false,
    this.styleSheet,
  });

  final String data;
  final bool selectable;
  final MarkdownStyleSheet? styleSheet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Clean up malformed markdown
    final cleanedData = _cleanMarkdown(data);
    
    final defaultStyleSheet = MarkdownStyleSheet(
      p: theme.textTheme.bodyMedium,
      h1: theme.textTheme.headlineLarge,
      h2: theme.textTheme.headlineMedium,
      h3: theme.textTheme.headlineSmall,
      h4: theme.textTheme.titleLarge,
      h5: theme.textTheme.titleMedium,
      h6: theme.textTheme.titleSmall,
      em: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
      strong: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      blockquote: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      code: theme.textTheme.bodySmall?.copyWith(
        fontFamily: 'monospace',
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
      ),
      codeblockDecoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: theme.colorScheme.primary,
            width: 4,
          ),
        ),
      ),
      listBullet: theme.textTheme.bodyMedium,
      listIndent: AppSpacing.lg,
      blockSpacing: AppSpacing.md,
    );

    final mergedStyleSheet = styleSheet ?? defaultStyleSheet;

    if (selectable) {
      return MarkdownBody(
        data: cleanedData,
        styleSheet: mergedStyleSheet,
        selectable: true,
      );
    }

    return MarkdownBody(
      data: cleanedData,
      styleSheet: mergedStyleSheet,
    );
  }

  String _cleanMarkdown(String text) {
    // Remove malformed bullet points like **2. or **4.
    var cleaned = text.replaceAllMapped(
      RegExp(r'\*\*(\d+)\.\s*(?!\*)'),
      (match) => '',
    );
    
    // Fix double asterisks at the start of lines
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'^(\s*)\*\*\s*(?!\*)', multiLine: true),
      (match) => '${match.group(1)}* ',
    );
    
    // Fix incomplete bold markers
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'\*\*([^*]+)(?:\*(?!\*)|$)'),
      (match) => '**${match.group(1)}**',
    );
    
    // Remove empty bullet points
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'^\s*\*\s*$', multiLine: true),
      (match) => '',
    );
    
    // Collapse multiple newlines
    cleaned = cleaned.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    
    return cleaned.trim();
  }
}
