import 'dart:async';
import 'package:web3_ai_assistant/repositories/transaction/transaction_repository.dart';
import 'package:web3_ai_assistant/repositories/transaction/models/transaction.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/models/transaction_info.dart' as web3;

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required this.web3Service});

  final Web3Service web3Service;
  final _transactionController = StreamController<List<Transaction>>.broadcast();
  List<Transaction> _currentTransactions = [];
  String? _subscribedAddress;
  Timer? _pollingTimer;

  @override
  Stream<List<Transaction>> get transactionStream => _transactionController.stream;

  @override
  List<Transaction> get currentTransactions => List.unmodifiable(_currentTransactions);

  @override
  Future<List<Transaction>> getRecentTransactions(
    String walletAddress, {
    int limit = 20,
    int? fromBlock,
    int? toBlock,
  }) async {
    try {
      // Fetch transactions from Web3Service
      final transactionInfos = await web3Service.getRecentTransactions(
        walletAddress,
        limit: limit,
      );

      // Convert TransactionInfo to Transaction DTOs
      final transactions = transactionInfos.map((info) => _mapToTransaction(info, walletAddress)).toList();

      // Update current transactions
      _currentTransactions = transactions;
      _transactionController.add(transactions);

      return transactions;
    } catch (e) {
      throw Exception('Failed to fetch recent transactions: $e');
    }
  }

  @override
  Future<List<Transaction>> getTransactionHistory(
    String walletAddress, {
    int page = 1,
    int pageSize = 20,
  }) async {
    // For now, use the same implementation as getRecentTransactions
    // In a real implementation, this would support proper pagination
    return getRecentTransactions(walletAddress, limit: pageSize);
  }

  @override
  Future<void> subscribeToTransactionUpdates(String walletAddress) async {
    // Unsubscribe from previous address if any
    await unsubscribeFromTransactionUpdates();

    _subscribedAddress = walletAddress;
    
    // Start polling for new transactions every 30 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      if (_subscribedAddress != null) {
        await getRecentTransactions(_subscribedAddress!);
      }
    });

    // Fetch initial transactions
    await getRecentTransactions(walletAddress);
  }

  @override
  Future<void> unsubscribeFromTransactionUpdates() async {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    _subscribedAddress = null;
  }

  @override
  void clearCache() {
    _currentTransactions = [];
    _transactionController.add([]);
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _transactionController.close();
  }

  Transaction _mapToTransaction(web3.TransactionInfo info, String walletAddress) {
    // Determine transaction type based on addresses
    final type = _determineTransactionType(info, walletAddress);

    // Handle token transfers
    if (info.tokenTransfers.isNotEmpty) {
      final tokenTransfer = info.tokenTransfers.first;
      return Transaction(
        hash: info.hash,
        from: info.from,
        to: info.to,
        value: tokenTransfer.value.toString(),
        timestamp: info.timestamp,
        blockNumber: info.blockNumber,
        status: _mapTransactionStatus(info.status),
        type: type,
        tokenAddress: tokenTransfer.tokenAddress,
        tokenSymbol: tokenTransfer.tokenSymbol,
        tokenDecimals: tokenTransfer.tokenDecimals,
        gasUsed: info.gasUsed.toString(),
      );
    }

    // Handle ETH transfers
    return Transaction(
      hash: info.hash,
      from: info.from,
      to: info.to,
      value: info.value.toString(),
      timestamp: info.timestamp,
      blockNumber: info.blockNumber,
      status: _mapTransactionStatus(info.status),
      type: type,
      gasUsed: info.gasUsed.toString(),
    );
  }

  TransactionType _determineTransactionType(web3.TransactionInfo info, String walletAddress) {
    final fromLower = info.from.toLowerCase();
    final toLower = info.to.toLowerCase();
    final addressLower = walletAddress.toLowerCase();

    if (fromLower == addressLower && toLower == addressLower) {
      return TransactionType.unknown;
    } else if (fromLower == addressLower) {
      return TransactionType.sent;
    } else if (toLower == addressLower) {
      return TransactionType.received;
    } else if (info.contractAddress != null) {
      return TransactionType.contract;
    }
    
    return TransactionType.unknown;
  }

  TransactionStatus _mapTransactionStatus(web3.TransactionStatus status) {
    switch (status) {
      case web3.TransactionStatus.pending:
        return TransactionStatus.pending;
      case web3.TransactionStatus.success:
        return TransactionStatus.completed;
      case web3.TransactionStatus.failed:
        return TransactionStatus.failed;
    }
  }
}
