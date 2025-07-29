import 'dart:async';
import 'package:web3_ai_assistant/repositories/wallet/models/wallet_state.dart';

/// Repository interface for wallet management operations
/// Provides abstraction over Web3 wallet interactions
abstract class WalletRepository {
  /// Stream of wallet state changes for reactive UI updates
  Stream<WalletState> get walletStateStream;
  
  /// Current wallet connection state
  WalletState get currentWalletState;

  /// Initiates wallet connection (e.g., MetaMask)
  Future<WalletState> connectWallet();
  
  /// Disconnects the currently connected wallet
  Future<WalletState> disconnectWallet();
  
  /// Refreshes wallet balance and network info
  Future<void> refreshWalletState();
  
  /// Cleanup resources and subscriptions
  void dispose();
}
