import 'package:web3_ai_assistant/services/web3/models/wallet_info.dart';

class WalletConnectionStatus {

  WalletConnectionStatus({
    required this.isConnected,
    required this.isConnecting,
    this.error,
    this.walletInfo,
  });

  factory WalletConnectionStatus.error(String error) {
    return WalletConnectionStatus(
      isConnected: false,
      isConnecting: false,
      error: error,
    );
  }

  factory WalletConnectionStatus.disconnected() {
    return WalletConnectionStatus(
      isConnected: false,
      isConnecting: false,
    );
  }

  factory WalletConnectionStatus.connecting() {
    return WalletConnectionStatus(
      isConnected: false,
      isConnecting: true,
    );
  }

  factory WalletConnectionStatus.connected(WalletInfo walletInfo) {
    return WalletConnectionStatus(
      isConnected: true,
      isConnecting: false,
      walletInfo: walletInfo,
    );
  }
  final bool isConnected;
  final bool isConnecting;
  final String? error;
  final WalletInfo? walletInfo;

  WalletConnectionStatus copyWith({
    bool? isConnected,
    bool? isConnecting,
    String? error,
    WalletInfo? walletInfo,
  }) {
    return WalletConnectionStatus(
      isConnected: isConnected ?? this.isConnected,
      isConnecting: isConnecting ?? this.isConnecting,
      error: error ?? this.error,
      walletInfo: walletInfo ?? this.walletInfo,
    );
  }
}
