import 'package:web3_ai_assistant/services/web3/models/wallet_info.dart';

class WalletState {

  WalletState({
    required this.isConnected,
    required this.isLoading,
    this.walletInfo,
    this.error,
  });

  factory WalletState.initial() {
    return WalletState(
      isConnected: false,
      isLoading: false,
    );
  }

  factory WalletState.loading() {
    return WalletState(
      isConnected: false,
      isLoading: true,
    );
  }

  factory WalletState.connected(WalletInfo walletInfo) {
    return WalletState(
      isConnected: true,
      isLoading: false,
      walletInfo: walletInfo,
    );
  }

  factory WalletState.disconnected() {
    return WalletState(
      isConnected: false,
      isLoading: false,
    );
  }

  factory WalletState.error(String error) {
    return WalletState(
      isConnected: false,
      isLoading: false,
      error: error,
    );
  }
  final bool isConnected;
  final bool isLoading;
  final WalletInfo? walletInfo;
  final String? error;

  WalletState copyWith({
    bool? isConnected,
    bool? isLoading,
    WalletInfo? walletInfo,
    String? error,
  }) {
    return WalletState(
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      walletInfo: walletInfo ?? this.walletInfo,
      error: error ?? this.error,
    );
  }
}