import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

class TokenSubtitle extends StatelessWidget {
  const TokenSubtitle({
    super.key,
    required this.token,
  });

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${token.balance.toStringAsFixed(4)} ${token.symbol}',
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
} 
