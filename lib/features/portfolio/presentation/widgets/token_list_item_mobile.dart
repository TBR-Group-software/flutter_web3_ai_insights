import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_icon.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_title.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_subtitle.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_trailing.dart';

class TokenListItemMobile extends StatelessWidget {
  const TokenListItemMobile({
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
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: ListTile(
        onTap: onTap,
        leading: TokenIcon(token: token),
        title: TokenTitle(token: token),
        subtitle: TokenSubtitle(token: token),
        trailing: TokenTrailing(token: token),
      ),
    );
  }
} 
