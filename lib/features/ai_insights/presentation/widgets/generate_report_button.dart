import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

class GenerateReportButton extends StatelessWidget {
  const GenerateReportButton({super.key, required this.onPressed, this.isLoading = false, this.isEnabled = true});

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilledButton.icon(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      icon:
          isLoading
              ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.onPrimary),
                ),
              )
              : const Icon(Icons.psychology),
      label: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: Text(isLoading ? 'Generating Report...' : 'Generate AI Report'),
      ),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
      ),
    );
  }
}
