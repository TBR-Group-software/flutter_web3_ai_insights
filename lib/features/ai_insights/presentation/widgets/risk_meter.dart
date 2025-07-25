import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/risk_meter_widget.dart';
import 'package:web3_ai_assistant/features/ai_insights/presentation/widgets/risk_section.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/risk_assessment.dart';

class RiskMeter extends StatelessWidget {
  const RiskMeter({super.key, required this.riskAssessment});

  final RiskAssessment riskAssessment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.shield_outlined, color: _getRiskColor(riskAssessment.level)),
                const SizedBox(width: AppSpacing.sm),
                Text('Risk Assessment', style: theme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            RiskMeterWidget(riskAssessment: riskAssessment),
            const SizedBox(height: AppSpacing.xl),
            Text(riskAssessment.description, style: theme.textTheme.bodyMedium),
            if (riskAssessment.concentrationRisks.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              RiskSection(
                title: 'Concentration Risks',
                items: riskAssessment.concentrationRisks,
                icon: Icons.pie_chart_outline,
              ),
            ],
            if (riskAssessment.volatilityRisks.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              RiskSection(
                title: 'Volatility Risks',
                items: riskAssessment.volatilityRisks,
                icon: Icons.show_chart,
              ),
            ],
            if (riskAssessment.mitigationStrategies.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.lg),
              RiskSection(
                title: 'Mitigation Strategies',
                items: riskAssessment.mitigationStrategies,
                icon: Icons.security,
                isPositive: true,
              ),
            ],
          ],
        ),
      ),
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
}
