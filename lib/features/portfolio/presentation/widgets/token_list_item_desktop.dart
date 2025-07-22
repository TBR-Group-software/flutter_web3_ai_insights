import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_icon.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_title.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_trailing.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_price.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_balance.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_change.dart';

class TokenListItemDesktop extends StatelessWidget {
  const TokenListItemDesktop({
    super.key,
    required this.token,
    this.onTap,
  });

  final PortfolioToken token;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: ListTile(
        onTap: onTap,
        leading: TokenIcon(token: token),
        title: Row(
          children: [
            Expanded(flex: 2, child: TokenTitle(token: token)),
            Expanded(child: TokenPrice(token: token)),
            Expanded(child: TokenBalance(token: token)),
            Expanded(child: TokenChange(token: token)),
          ],
        ),
        trailing: TokenTrailing(token: token),
      ),
    );
  }
} 
