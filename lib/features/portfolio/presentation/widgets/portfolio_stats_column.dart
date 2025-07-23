import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/mobile_stat_item.dart';

class PortfolioStatsColumn extends StatelessWidget {
  const PortfolioStatsColumn({
    super.key,
    required this.tokens,
  });

  final List<PortfolioToken> tokens;

  @override
  Widget build(BuildContext context) {
    final totalValue = tokens.fold<double>(0, (sum, token) => sum + token.totalValue);
    final totalChange = tokens.fold<double>(0, (sum, token) => sum + token.changePercent24h);
    final averageChange = tokens.isEmpty ? 0.0 : totalChange / tokens.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MobileStatItem(
          label: 'Total Value',
          value: '\$${totalValue.toStringAsFixed(2)}',
          icon: Icons.attach_money,
        ),
        const SizedBox(height: AppSpacing.sm),
        MobileStatItem(
          label: '24h Change',
          value: '${averageChange >= 0 ? '+' : ''}${averageChange.toStringAsFixed(2)}%',
          icon: averageChange >= 0 ? Icons.trending_up : Icons.trending_down,
          color: averageChange >= 0
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: AppSpacing.sm),
        MobileStatItem(
          label: 'Tokens',
          value: '${tokens.length}',
          icon: Icons.token,
        ),
      ],
    );
  }
}
