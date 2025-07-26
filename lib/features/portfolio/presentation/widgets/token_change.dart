import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_change_indicator.dart';

class TokenChange extends StatelessWidget {
  const TokenChange({super.key, required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return TokenChangeIndicator(token: token);
  }
}
