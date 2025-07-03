import 'dart:async';
import 'package:web3_ai_assistant/services/web3/models/wallet_connection_status.dart';

abstract class Web3Service {
  Stream<WalletConnectionStatus> get connectionStatusStream;
  WalletConnectionStatus get currentConnectionStatus;

  Future<WalletConnectionStatus> connect();
  Future<WalletConnectionStatus> disconnect();
  Future<BigInt?> getBalance(String address);
  Future<int?> getChainId();
  Future<String?> getNetworkName(int chainId);

  void dispose();
}
