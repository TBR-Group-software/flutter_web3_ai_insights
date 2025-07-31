import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

class TokenChangeIndicator extends StatelessWidget {
  const TokenChangeIndicator({super.key, required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    final isPositive = token.changePercent24h >= 0;
    final color = isPositive ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, size: 12, color: color),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '${token.changePercent24h.abs().toStringAsFixed(2)}%',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
