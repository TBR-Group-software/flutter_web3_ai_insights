import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

class TokenIcon extends StatelessWidget {
  const TokenIcon({super.key, required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child:
          token.logoUri != null
              ? ClipOval(
                child: Image.network(
                  token.logoUri!,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => _DefaultIcon(token: token),
                ),
              )
              : _DefaultIcon(token: token),
    );
  }
}

class _DefaultIcon extends StatelessWidget {
  const _DefaultIcon({required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return Text(
      token.symbol.isNotEmpty ? token.symbol[0].toUpperCase() : '?',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
