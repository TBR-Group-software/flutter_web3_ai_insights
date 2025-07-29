import 'dart:async';
import 'package:web3_ai_assistant/repositories/portfolio/models/portfolio_token.dart';

/// Repository interface for portfolio management
/// Combines Web3 token balances with real-time price data
abstract class PortfolioRepository {
  /// Stream of portfolio updates with real-time prices
  Stream<List<PortfolioToken>> get portfolioStream;
  
  /// Current portfolio snapshot
  List<PortfolioToken> get currentPortfolio;

  /// Fetches token balances and prices for a wallet address
  Future<List<PortfolioToken>> getPortfolio(String walletAddress);
  
  /// Forces refresh of portfolio data from blockchain
  Future<void> refreshPortfolio(String walletAddress);
  
  /// Subscribes to real-time price updates via WebSocket
  Future<void> subscribeToPortfolioUpdates(String walletAddress);
  
  /// Stops real-time price updates
  Future<void> unsubscribeFromPortfolioUpdates();

  /// Cleanup resources and subscriptions
  void dispose();
}
