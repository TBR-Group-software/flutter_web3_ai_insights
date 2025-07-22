import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_card.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_list_item.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_details_dialog.dart';

class PortfolioContentWidget extends StatelessWidget {
  const PortfolioContentWidget({
    super.key,
    required this.tokens,
  });

  final List<PortfolioToken> tokens;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PortfolioSummaryCard(tokens: tokens),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppSpacing.md),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => TokenListItem(
              token: tokens[index],
              onTap: () => _showTokenDetails(context, tokens[index]),
            ),
            childCount: tokens.length,
          ),
        ),
      ],
    );
  }

  void _showTokenDetails(BuildContext context, PortfolioToken token) {
    showDialog(
      context: context,
      builder: (context) => TokenDetailsDialog(token: token),
    );
  }
} 
