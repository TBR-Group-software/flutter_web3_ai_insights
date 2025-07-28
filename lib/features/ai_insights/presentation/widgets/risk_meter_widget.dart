import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/risk_assessment.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class RiskMeterWidget extends StatelessWidget {
  const RiskMeterWidget({super.key, required this.riskAssessment});

  final RiskAssessment riskAssessment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final riskColor = _getRiskColor(riskAssessment.level);
    final riskLabel = _getRiskLabel(context, riskAssessment.level);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              riskLabel,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: riskColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              l10n.riskScore(riskAssessment.riskScore.toInt()),
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: riskAssessment.riskScore / 100,
            minHeight: 12,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(riskColor),
          ),
        ),
      ],
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
    }
  }

  String _getRiskLabel(BuildContext context, RiskLevel level) {
    final l10n = AppLocalizations.of(context)!;
    switch (level) {
      case RiskLevel.low:
        return l10n.riskLow;
      case RiskLevel.medium:
        return l10n.riskMedium;
      case RiskLevel.high:
        return l10n.riskHigh;
    }
  }
}
