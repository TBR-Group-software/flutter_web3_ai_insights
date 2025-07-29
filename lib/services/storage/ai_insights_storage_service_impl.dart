import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3_ai_assistant/repositories/ai_insights/models/portfolio_analysis.dart';
import 'package:web3_ai_assistant/services/storage/ai_insights_storage_service.dart';

/// Local storage implementation for AI insights history
/// Uses SharedPreferences to persist analysis results across app sessions
class AiInsightsStorageServiceImpl implements AiInsightsStorageService {
  AiInsightsStorageServiceImpl({Logger? logger}) : _logger = logger ?? Logger();

  final Logger _logger;

  static const String _storageKey = 'ai_insights_history';
  static const int _maxHistorySize = 5; // Keep only recent analyses to save space

  @override
  Future<List<PortfolioAnalysis>> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        _logger.i('No AI insights history found in storage');
        return [];
      }

      final jsonList = json.decode(jsonString) as List<dynamic>;
      final analyses = jsonList
          .map((json) => PortfolioAnalysis.fromJson(json as Map<String, dynamic>))
          .toList();
      
      _logger.i('Loaded ${analyses.length} AI insights from storage');
      return analyses;
    } catch (e) {
      _logger.e('Error loading AI insights history: $e');
      return [];
    }
  }

  @override
  Future<void> saveAnalysis(PortfolioAnalysis analysis) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load existing history
      var history = await loadHistory();
      
      // Add new analysis at the beginning
      history.insert(0, analysis);
      
      // Keep only the most recent analyses
      if (history.length > _maxHistorySize) {
        history = history.take(_maxHistorySize).toList();
      }
      
      // Convert to JSON and save
      final jsonList = history.map((a) => a.toJson()).toList();
      final jsonString = json.encode(jsonList);
      
      await prefs.setString(_storageKey, jsonString);
      _logger.i('Saved AI analysis to storage. Total history: ${history.length}');
    } catch (e) {
      _logger.e('Error saving AI analysis: $e');
      rethrow;
    }
  }

  @override
  Future<void> clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
      _logger.i('Cleared AI insights history');
    } catch (e) {
      _logger.e('Error clearing AI insights history: $e');
      rethrow;
    }
  }

  @override
  Future<PortfolioAnalysis?> getLatestAnalysis() async {
    final history = await loadHistory();
    return history.isNotEmpty ? history.first : null;
  }

  @override
  Future<int> getHistoryCount() async {
    final history = await loadHistory();
    return history.length;
  }
}
