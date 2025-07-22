import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/core/widgets/responsive_builder.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_list_item_mobile.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_list_item_tablet.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_list_item_desktop.dart';

class TokenListItem extends StatelessWidget {
  const TokenListItem({
    super.key,
    required this.token,
    this.onTap,
  });

  final PortfolioToken token;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: TokenListItemMobile(token: token, onTap: onTap),
      tablet: TokenListItemTablet(token: token, onTap: onTap),
      desktop: TokenListItemDesktop(token: token, onTap: onTap),
    );
  }


} 
