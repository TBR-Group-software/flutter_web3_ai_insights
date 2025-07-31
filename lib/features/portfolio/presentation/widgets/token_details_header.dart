import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/features/portfolio/presentation/widgets/token_icon.dart';

class TokenDetailsHeader extends StatelessWidget {
  const TokenDetailsHeader({super.key, required this.token, this.onClose});

  final PortfolioToken token;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TokenIcon(token: token),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                token.symbol.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (token.name.isNotEmpty && token.name != token.symbol)
                Text(
                  token.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
            ],
          ),
        ),
        if (onClose != null) IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
      ],
    );
  }
}
