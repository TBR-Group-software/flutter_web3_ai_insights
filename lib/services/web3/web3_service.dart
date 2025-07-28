import 'dart:async';
import 'package:web3_ai_assistant/services/web3/models/wallet_connection_status.dart';
import 'package:web3_ai_assistant/services/web3/models/token_balance.dart';
import 'package:web3_ai_assistant/services/web3/models/transaction_info.dart';

abstract class Web3Service {
  Stream<WalletConnectionStatus> get connectionStatusStream;
  WalletConnectionStatus get currentConnectionStatus;

  Future<WalletConnectionStatus> connect();
  Future<WalletConnectionStatus> disconnect();
  Future<BigInt?> getBalance(String address);
  Future<int?> getChainId();
  Future<String?> getNetworkName(int chainId);
  Future<List<TokenBalance>> getTokenBalances(String walletAddress);
  Future<List<TransactionInfo>> getRecentTransactions(String walletAddress, {int limit = 10});

  void dispose();
}
