import 'dart:async';
import 'package:web3_ai_assistant/repositories/transaction/models/transaction.dart';

abstract class TransactionRepository {
  /// Stream of transactions for real-time updates
  Stream<List<Transaction>> get transactionStream;
  
  /// Current list of transactions
  List<Transaction> get currentTransactions;
  
  /// Fetch recent transactions for a wallet address
  Future<List<Transaction>> getRecentTransactions(
    String walletAddress, {
    int limit = 20,
    int? fromBlock,
    int? toBlock,
  });
  
  /// Fetch transactions with pagination
  Future<List<Transaction>> getTransactionHistory(
    String walletAddress, {
    int page = 1,
    int pageSize = 20,
  });
  
  /// Subscribe to real-time transaction updates
  Future<void> subscribeToTransactionUpdates(String walletAddress);
  
  /// Unsubscribe from transaction updates
  Future<void> unsubscribeFromTransactionUpdates();
  
  /// Clear transaction cache
  void clearCache();
  
  /// Dispose of resources
  void dispose();
}
