import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_details_header.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_price_info.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_holdings_info.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_total_value.dart';

class TokenDetailsDialog extends StatelessWidget {
  const TokenDetailsDialog({super.key, required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TokenDetailsHeader(token: token, onClose: () => Navigator.of(context).pop()),
            const SizedBox(height: AppSpacing.lg),
            TokenPriceInfo(token: token),
            const SizedBox(height: AppSpacing.md),
            TokenHoldingsInfo(token: token),
            const SizedBox(height: AppSpacing.md),
            TokenTotalValue(token: token),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
            ),
          ],
        ),
      ),
    );
  }
}
