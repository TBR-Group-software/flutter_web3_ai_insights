import 'dart:async';
import 'package:web3_ai_assistant/repositories/wallet/models/wallet_state.dart';

abstract class WalletRepository {
  Stream<WalletState> get walletStateStream;
  WalletState get currentWalletState;

  Future<WalletState> connectWallet();
  Future<WalletState> disconnectWallet();
  Future<void> refreshWalletState();
  void dispose();
}
