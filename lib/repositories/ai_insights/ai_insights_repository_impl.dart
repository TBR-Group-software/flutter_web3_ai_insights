import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/ai_insights_repository.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/risk_assessment.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/investment_recommendation.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/market_insight.dart';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';
import 'package:web3_ai_assistant/services/gemini/gemini_service.dart';
import 'package:web3_ai_assistant/services/gemini/models/generate_content_request.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/parsers/gemini_response_parser.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/prompts/portfolio_analysis_prompts.dart';

class AiInsightsRepositoryImpl implements AiInsightsRepository {
  AiInsightsRepositoryImpl({
    required GeminiService geminiService,
    required String apiKey,
    required String modelName,
    Logger? logger,
  }) : _geminiService = geminiService,
       _apiKey = apiKey,
       _modelName = modelName,
       _logger = logger ?? Logger(),
       _responseParser = GeminiResponseParser(logger: logger);

  final GeminiService _geminiService;
  final String _apiKey;
  final String _modelName;
  final Logger _logger;
  final GeminiResponseParser _responseParser;
  final _uuid = const Uuid();

  // Simple in-memory cache
  final Map<String, PortfolioAnalysis> _analysisCache = {};
  static const _cacheDuration = Duration(minutes: 5);

  @override
  Future<PortfolioAnalysis> generatePortfolioAnalysis(List<PortfolioToken> tokens) async {
    try {
      if (tokens.isEmpty) {
        throw Exception('Cannot analyze empty portfolio');
      }

      // Check cache first
      final cacheKey = _generateCacheKey(tokens);
      final cached = _analysisCache[cacheKey];
      if (cached != null && _isCacheValid(cached.generatedAt)) {
        _logger.i('Returning cached analysis');
        return cached;
      }

      _logger.i('Generating portfolio analysis for ${tokens.length} tokens');

      // Generate prompt
      final prompt = PortfolioAnalysisPrompts.generatePortfolioAnalysisPrompt(tokens);

      // Create request
      final request = GenerateContentRequest(
        contents: [
          Content(parts: [Part(text: prompt)]),
        ],
        generationConfig: const GenerationConfig(temperature: 0.7, topP: 0.95, topK: 40, maxOutputTokens: 2048),
      );

      // Call Gemini API
      final response = await _geminiService.generateContent(_modelName, request, _apiKey);

      // Parse response
      final analysisText = _responseParser.parseTextResponse(response);
      if (analysisText == null) {
        throw Exception('Failed to parse AI response');
      }

      // Check safety
      if (!_responseParser.isResponseSafe(response)) {
        throw Exception('AI response failed safety checks');
      }

      // Parse the analysis text into structured data
      final analysis = _parseAnalysisResponse(analysisText, tokens);

      // Cache the result
      _analysisCache[cacheKey] = analysis;

      _logger.i('Portfolio analysis generated successfully');
      return analysis;
    } catch (e) {
      _logger.e('Error generating portfolio analysis: $e');
      rethrow;
    }
  }

  @override
  Future<String> generateQuickInsight(List<PortfolioToken> tokens) async {
    try {
      if (tokens.isEmpty) {
        return 'No tokens in portfolio to analyze.';
      }

      _logger.i('Generating quick insight for ${tokens.length} tokens');

      // Generate prompt
      final prompt = PortfolioAnalysisPrompts.generateQuickInsightPrompt(tokens);

      // Create request
      final request = GenerateContentRequest(
        contents: [
          Content(parts: [Part(text: prompt)]),
        ],
        generationConfig: const GenerationConfig(temperature: 0.5, maxOutputTokens: 200),
      );

      // Call Gemini API
      final response = await _geminiService.generateContent(_modelName, request, _apiKey);

      // Parse response
      final insight = _responseParser.parseTextResponse(response);
      if (insight == null) {
        throw Exception('Failed to parse AI response');
      }

      return insight;
    } catch (e) {
      _logger.e('Error generating quick insight: $e');
      return 'Unable to generate insight at this time.';
    }
  }

  @override
  Future<void> clearCache() async {
    _analysisCache.clear();
    _logger.i('Analysis cache cleared');
  }

  String _generateCacheKey(List<PortfolioToken> tokens) {
    final symbols = tokens.map((t) => t.symbol).toList()..sort();
    final values = tokens.map((t) => t.totalValue.toStringAsFixed(2)).join(',');
    return '${symbols.join(',')}_$values';
  }

  bool _isCacheValid(DateTime generatedAt) {
    return DateTime.now().difference(generatedAt) < _cacheDuration;
  }

  PortfolioAnalysis _parseAnalysisResponse(String analysisText, List<PortfolioToken> tokens) {
    // This is a simplified parser. In a production app, you might want to use
    // more sophisticated parsing or have the AI return structured JSON

    final totalValue = tokens.fold(0.0, (sum, token) => sum + token.totalValue);

    // Extract sections from the analysis text
    final sections = _extractSections(analysisText);

    // Parse risk assessment
    final riskAssessment = _parseRiskAssessment(sections['riskAssessment'] ?? '');

    // Parse recommendations
    final recommendations = _parseRecommendations(sections['recommendations'] ?? '');

    // Parse market insights
    final marketInsights = _parseMarketInsights(sections['marketContext'] ?? '');

    return PortfolioAnalysis(
      id: _uuid.v4(),
      generatedAt: DateTime.now(),
      overview: sections['overview'] ?? 'Portfolio analysis completed.',
      riskAssessment: riskAssessment,
      performanceSummary: sections['performance'] ?? 'Performance data analyzed.',
      recommendations: recommendations,
      marketInsights: marketInsights,
      portfolioValue: totalValue,
      tokenCount: tokens.length,
      rawAnalysis: analysisText,
    );
  }

  Map<String, String> _extractSections(String text) {
    final sections = <String, String>{};

    // Extract sections based on markdown headers
    final overviewMatch = RegExp(
      r'##\s*Portfolio Overview\s*(.+?)(?=##\s*Risk Assessment|##\s*Performance|$)',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(text);
    if (overviewMatch != null) {
      sections['overview'] = _cleanSectionText(overviewMatch.group(1) ?? '');
    }

    final riskMatch = RegExp(
      r'##\s*Risk Assessment\s*(.+?)(?=##\s*Performance|##\s*Strategic|$)',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(text);
    if (riskMatch != null) {
      sections['riskAssessment'] = _cleanSectionText(riskMatch.group(1) ?? '');
    }

    final performanceMatch = RegExp(
      r'##\s*Performance Analysis\s*(.+?)(?=##\s*Strategic|##\s*Market|$)',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(text);
    if (performanceMatch != null) {
      sections['performance'] = _cleanSectionText(performanceMatch.group(1) ?? '');
    }

    final recommendationsMatch = RegExp(
      r'##\s*Strategic Recommendations\s*(.+?)(?=##\s*Market|$)',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(text);
    if (recommendationsMatch != null) {
      sections['recommendations'] = _cleanSectionText(recommendationsMatch.group(1) ?? '');
    }

    final marketMatch = RegExp(
      r'##\s*Market Context\s*(.+?)$',
      caseSensitive: false,
      dotAll: true,
    ).firstMatch(text);
    if (marketMatch != null) {
      sections['marketContext'] = _cleanSectionText(marketMatch.group(1) ?? '');
    }

    return sections;
  }
  
  String _cleanSectionText(String text) {
    // Remove malformed bullet points and clean up text
    var cleaned = text.trim();
    
    // Remove **number. patterns
    cleaned = cleaned.replaceAll(RegExp(r'\*\*\d+\.\s*'), '');
    
    // Remove all ** markdown bold formatting
    cleaned = cleaned.replaceAll('**', '');
    
    // Fix double asterisks at start of lines
    cleaned = cleaned.replaceAll(RegExp(r'^\*\*\s*(?!\*)', multiLine: true), '- ');
    
    // Remove empty lines
    cleaned = cleaned.replaceAll(RegExp(r'\n\s*\n\s*\n'), '\n\n');
    
    return cleaned.trim();
  }

  RiskAssessment _parseRiskAssessment(String text) {
    // Determine risk level
    var level = RiskLevel.medium;
    if (text.toLowerCase().contains('high risk') || text.toLowerCase().contains('significant risk')) {
      level = RiskLevel.high;
    } else if (text.toLowerCase().contains('low risk') || text.toLowerCase().contains('minimal risk')) {
      level = RiskLevel.low;
    }

    // Extract risk factors
    final concentrationRisks = <String>[];
    final volatilityRisks = <String>[];
    final mitigationStrategies = <String>[];

    // Simple extraction of bullet points
    final lines = text.split('\n');
    for (final line in lines) {
      if (line.contains('concentration') || line.contains('diversification')) {
        concentrationRisks.add(line.trim().replaceAll(RegExp(r'^[-*•]\s*'), ''));
      } else if (line.contains('volatility') || line.contains('fluctuation')) {
        volatilityRisks.add(line.trim().replaceAll(RegExp(r'^[-*•]\s*'), ''));
      } else if (line.contains('mitigation') || line.contains('reduce risk')) {
        mitigationStrategies.add(line.trim().replaceAll(RegExp(r'^[-*•]\s*'), ''));
      }
    }

    // Calculate risk score (0-100)
    var riskScore = 50.0;
    if (level == RiskLevel.high) {
      riskScore = 70.0 + (concentrationRisks.length * 5).clamp(0, 30);
    } else if (level == RiskLevel.low) {
      riskScore = 30.0 - (mitigationStrategies.length * 5).clamp(0, 20);
    }

    return RiskAssessment(
      level: level,
      description: text.split('\n').first.trim(),
      concentrationRisks: concentrationRisks.isEmpty ? ['Portfolio appears well-balanced'] : concentrationRisks,
      volatilityRisks: volatilityRisks.isEmpty ? ['Market volatility within normal range'] : volatilityRisks,
      mitigationStrategies:
          mitigationStrategies.isEmpty ? ['Continue monitoring portfolio performance'] : mitigationStrategies,
      riskScore: riskScore.clamp(0, 100),
    );
  }

  List<InvestmentRecommendation> _parseRecommendations(String text) {
    final recommendations = <InvestmentRecommendation>[];
    final processedTitles = <String>{};  // Track unique recommendations

    // Split by bullet points
    final items = text.split(RegExp(r'\n(?=-\s)'));

    for (final item in items) {
      final trimmedItem = item.trim();
      if (trimmedItem.isEmpty || trimmedItem == '-') {
        continue;
      }

      // Extract parts of the recommendation
      final lines = trimmedItem.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
      if (lines.isEmpty) {
        continue;
      }

      // Parse first line as title
      var title = lines.first.replaceAll(RegExp(r'^-\s*'), '').trim();
      // Remove any remaining ** formatting
      title = title.replaceAll('**', '');
      if (title.isEmpty) {
        continue;
      }
      
      // Extract title from patterns like "Clear action title: Description"
      if (title.contains(':')) {
        final parts = title.split(':');
        if (parts.first.toLowerCase().contains('clear action') || 
            parts.first.toLowerCase().contains('title')) {
          title = parts.length > 1 ? parts[1].trim() : title;
        } else {
          title = parts.first.trim();
        }
      }
      
      // Skip if we've already processed this recommendation
      if (processedTitles.contains(title)) {
        continue;
      }
      processedTitles.add(title);

      // Extract description, priority, and reasoning from subsequent lines
      var description = '';
      var reasoning = '';
      var priority = RecommendationPriority.medium;
      
      for (var i = 1; i < lines.length; i++) {
        final line = lines[i];
        final lowerLine = line.toLowerCase();
        
        if (lowerLine.contains('priority') && lowerLine.contains('high')) {
          priority = RecommendationPriority.high;
        } else if (lowerLine.contains('priority') && lowerLine.contains('low')) {
          priority = RecommendationPriority.low;
        } else if (lowerLine.contains('reasoning:') || lowerLine.contains('because')) {
          reasoning = line.replaceAll(RegExp(r'^.*?(reasoning:|because)\s*', caseSensitive: false), '').trim();
        } else if (lowerLine.contains('description:') || !line.startsWith('-')) {
          var cleanedLine = line.replaceAll(RegExp(r'^.*?description:\s*', caseSensitive: false), '').trim();
          // Remove any ** formatting from description
          cleanedLine = cleanedLine.replaceAll('**', '');
          if (cleanedLine.isNotEmpty && !cleanedLine.startsWith('Priority')) {
            description += (description.isEmpty ? '' : ' ') + cleanedLine;
          }
        }
      }
      
      // If no description found, use title as description
      if (description.isEmpty) {
        description = title;
      }

      // Determine recommendation type
      var type = RecommendationType.hold;
      final lowerTitle = title.toLowerCase();
      final lowerDesc = description.toLowerCase();
      
      if (lowerTitle.contains('buy') || lowerTitle.contains('increase') || 
          lowerDesc.contains('buy') || lowerDesc.contains('increase')) {
        type = RecommendationType.buy;
      } else if (lowerTitle.contains('sell') || lowerTitle.contains('reduce') ||
                 lowerDesc.contains('sell') || lowerDesc.contains('reduce')) {
        type = RecommendationType.sell;
      } else if (lowerTitle.contains('rebalanc') || lowerDesc.contains('rebalanc')) {
        type = RecommendationType.rebalance;
      } else if (lowerTitle.contains('diversif') || lowerDesc.contains('diversif')) {
        type = RecommendationType.diversify;
      }

      recommendations.add(
        InvestmentRecommendation(
          title: title.length > 60 ? '${title.substring(0, 57)}...' : title,
          description: description,
          type: type,
          priority: priority,
          reasoning: reasoning.isNotEmpty ? reasoning : null,
        ),
      );
    }

    // Ensure we have at least one recommendation
    if (recommendations.isEmpty) {
      recommendations.add(
        const InvestmentRecommendation(
          title: 'Continue Monitoring',
          description: 'Keep tracking your portfolio performance and market conditions.',
          type: RecommendationType.hold,
          priority: RecommendationPriority.medium,
        ),
      );
    }

    return recommendations.take(5).toList();  // Limit to 5 recommendations
  }

  List<MarketInsight> _parseMarketInsights(String text) {
    final insights = <MarketInsight>[];
    final processedTitles = <String>{};  // Track unique insights

    // Split by bullet points
    final items = text.split(RegExp(r'\n(?=-\s)'));

    for (final item in items) {
      final trimmedItem = item.trim();
      if (trimmedItem.isEmpty || trimmedItem == '-') {
        continue;
      }

      // Extract lines
      final lines = trimmedItem.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
      if (lines.isEmpty) {
        continue;
      }

      // Parse first line as title
      var title = lines.first.replaceAll(RegExp(r'^-\s*'), '').trim();
      // Remove any remaining ** formatting
      title = title.replaceAll('**', '');
      if (title.isEmpty) {
        continue;
      }
      
      // Clean up title
      if (title.contains(':')) {
        final parts = title.split(':');
        title = parts.first.trim();
      }
      
      // Skip if we've already processed this insight
      if (processedTitles.contains(title)) {
        continue;
      }
      processedTitles.add(title);

      // Build description from remaining lines
      final descriptionLines = <String>[];
      var impact = '';
      
      for (var i = 1; i < lines.length; i++) {
        final line = lines[i];
        if (line.toLowerCase().contains('impact:') || 
            line.toLowerCase().contains('portfolio impact')) {
          impact = line.replaceAll(RegExp(r'^.*?(impact:|portfolio impact)\s*', caseSensitive: false), '').trim();
        } else if (!line.startsWith('-')) {
          descriptionLines.add(line);
        }
      }
      
      final description = descriptionLines.join(' ').trim();
      if (description.isEmpty && title == description) {
        continue;
      }

      // Determine insight type
      var type = InsightType.trend;
      final lowerText = '$title $description'.toLowerCase();
      
      if (lowerText.contains('opportunity') || lowerText.contains('potential gain')) {
        type = InsightType.opportunity;
      } else if (lowerText.contains('warning') || lowerText.contains('caution') || 
                 lowerText.contains('risk') || lowerText.contains('concern')) {
        type = InsightType.warning;
      } else if (lowerText.contains('news') || lowerText.contains('announcement') ||
                 lowerText.contains('update')) {
        type = InsightType.news;
      }

      insights.add(
        MarketInsight(
          title: title.length > 60 ? '${title.substring(0, 57)}...' : title,
          description: description.isNotEmpty ? description : title,
          type: type,
          impact: impact.isNotEmpty ? impact : null,
        ),
      );
    }

    // Ensure we have at least one insight
    if (insights.isEmpty) {
      insights.add(
        const MarketInsight(
          title: 'Market Analysis',
          description: 'Current market conditions are being monitored for your portfolio.',
          type: InsightType.trend,
        ),
      );
    }

    return insights.take(5).toList();  // Limit to 5 insights
  }
}
