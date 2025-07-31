import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

class PortfolioAnalysisPrompts {
  static String generatePortfolioAnalysisPrompt(List<PortfolioToken> tokens) {
    final totalValue = tokens.fold(0.0, (sum, token) => sum + token.totalValue);
    final portfolioData =
        tokens
            .map(
              (token) => {
                'symbol': token.symbol,
                'name': token.name,
                'balance': token.balance,
                'price': token.price,
                'value': token.totalValue,
                'allocation': '${((token.totalValue / totalValue) * 100).toStringAsFixed(2)}%',
                'change24h': '${token.changePercent24h.toStringAsFixed(2)}%',
              },
            )
            .toList();

    return '''
You are an expert cryptocurrency portfolio analyst. Analyze the following Web3 portfolio and provide comprehensive insights:

PORTFOLIO DATA:
Total Portfolio Value: \$${totalValue.toStringAsFixed(2)}

HOLDINGS:
${_formatHoldings(portfolioData)}

Please provide a detailed analysis with the following exact structure:

## Portfolio Overview
Provide a comprehensive assessment covering:
- Overall portfolio health and current state
- Diversification analysis (is the portfolio well-balanced?)
- Market positioning within the broader crypto ecosystem

## Risk Assessment
Analyze the portfolio risk profile:
- Overall Risk Level: [Clearly state Low/Medium/High]
- Key concentration risks (if any holdings dominate the portfolio)
- Market volatility exposure analysis
- Specific risks for each major holding

## Performance Analysis
Summarize recent performance:
- 24-hour performance overview with specific numbers
- Identify top performers and underperformers
- Analyze alignment with broader market trends

## Strategic Recommendations
Provide 3-5 specific, actionable recommendations. For each recommendation:
- Clear action title
- Detailed description of what to do
- Priority level (High/Medium/Low)
- Reasoning behind the recommendation

## Market Context
Analyze current market conditions:
- How current crypto market conditions affect this portfolio
- Sector-specific insights relevant to the holdings
- Future outlook and important considerations

IMPORTANT FORMATTING RULES:
- Use proper markdown headers (##) for main sections
- Use bullet points (-) for lists, not asterisks
- Do not use numbered lists within bullet points
- Keep each point concise and clear
- Avoid incomplete sentences or fragments
- Ensure all recommendations are complete and actionable
''';
  }

  static String _formatHoldings(List<Map<String, dynamic>> holdings) {
    return holdings
        .map(
          (holding) => '''
- ${holding['symbol']} (${holding['name']})
  * Holdings: ${holding['balance']} tokens
  * Current Price: \$${holding['price']}
  * Total Value: \$${holding['value']}
  * Portfolio Allocation: ${holding['allocation']}
  * 24h Change: ${holding['change24h']}
''',
        )
        .join('\n');
  }

  static String generateQuickInsightPrompt(List<PortfolioToken> tokens) {
    final totalValue = tokens.fold(0.0, (sum, token) => sum + token.totalValue);
    final topHoldings = tokens
        .take(3)
        .map((t) => '${t.symbol}: ${((t.totalValue / totalValue) * 100).toStringAsFixed(1)}%')
        .join(', ');

    return '''
Provide a quick 2-3 sentence insight about this crypto portfolio:
- Total Value: \$${totalValue.toStringAsFixed(2)}
- Number of Assets: ${tokens.length}
- Top Holdings: $topHoldings
- 24h Performance: ${_calculate24hPerformance(tokens).toStringAsFixed(2)}%

Focus on the most important observation about risk, diversification, or opportunity.
''';
  }

  static double _calculate24hPerformance(List<PortfolioToken> tokens) {
    if (tokens.isEmpty) {
      return 0.0;
    }

    final totalValue = tokens.fold(0.0, (sum, token) => sum + token.totalValue);
    final weightedChange = tokens.fold(0.0, (sum, token) {
      final weight = token.totalValue / totalValue;
      return sum + (token.changePercent24h * weight);
    });

    return weightedChange;
  }
}
