import 'dart:async';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

abstract class PortfolioRepository {
  Stream<List<PortfolioToken>> get portfolioStream;
  List<PortfolioToken> get currentPortfolio;

  Future<List<PortfolioToken>> getPortfolio(String walletAddress);
  Future<void> refreshPortfolio(String walletAddress);
  Future<void> subscribeToPortfolioUpdates(String walletAddress);
  Future<void> unsubscribeFromPortfolioUpdates();

  void dispose();
}
