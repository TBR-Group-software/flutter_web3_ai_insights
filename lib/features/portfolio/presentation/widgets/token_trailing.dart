import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

class TokenTrailing extends StatelessWidget {
  const TokenTrailing({super.key, required this.token});

  final PortfolioToken token;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '\$${token.totalValue.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (token.lastUpdated != null)
          Text(
            _formatLastUpdated(token.lastUpdated!),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
      ],
    );
  }

  String _formatLastUpdated(DateTime lastUpdated) {
    final now = DateTime.now();
    final difference = now.difference(lastUpdated);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
