import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_change_indicator.dart';

class TokenPrice extends StatelessWidget {
  const TokenPrice({
    super.key,
    required this.token,
  });

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$${token.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        TokenChangeIndicator(token: token),
      ],
    );
  }
} 
