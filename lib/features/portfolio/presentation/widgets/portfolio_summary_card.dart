import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_builder.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_card_mobile.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_card_tablet.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/portfolio_summary_card_desktop.dart';

class PortfolioSummaryCard extends StatelessWidget {
  const PortfolioSummaryCard({super.key, required this.tokens, this.isLoading = false});

  final List<PortfolioToken> tokens;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: PortfolioSummaryCardMobile(tokens: tokens, isLoading: isLoading),
      tablet: PortfolioSummaryCardTablet(tokens: tokens, isLoading: isLoading),
      desktop: PortfolioSummaryCardDesktop(tokens: tokens, isLoading: isLoading),
    );
  }
}
