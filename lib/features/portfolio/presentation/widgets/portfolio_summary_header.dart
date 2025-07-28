import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/l10n/generated/app_localizations.dart';

class PortfolioSummaryHeader extends StatelessWidget {
  const PortfolioSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Icon(Icons.account_balance_wallet_outlined, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            l10n.portfolioSummary,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
