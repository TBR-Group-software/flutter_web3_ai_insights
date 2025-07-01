import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Mock wallet connection state provider
/// This will be replaced with real wallet connection logic later
final walletConnectionStateProvider = StateProvider<WalletConnectionState>((ref) {
  return WalletConnectionState.disconnected;
});

/// Dashboard loading state provider
final dashboardLoadingProvider = StateProvider<bool>((ref) => false);

/// Selected navigation index provider
final selectedNavigationIndexProvider = StateProvider<int>((ref) => 0);

/// Mock portfolio value provider
/// This will be replaced with real data later
final mockPortfolioValueProvider = Provider<double>((ref) {
  return 125432.56; // Mock value in USD
});

/// Mock recent transactions provider
/// This will be replaced with real data later
final mockRecentTransactionsProvider = Provider<List<MockTransaction>>((ref) {
  return [
    MockTransaction(
      type: 'Received',
      amount: '0.5 ETH',
      time: '2 hours ago',
      status: TransactionStatus.completed,
    ),
    MockTransaction(
      type: 'Sent',
      amount: '100 USDC',
      time: '5 hours ago',
      status: TransactionStatus.completed,
    ),
    MockTransaction(
      type: 'Swap',
      amount: '0.1 ETH → 350 USDC',
      time: '1 day ago',
      status: TransactionStatus.pending,
    ),
  ];
});

/// Wallet connection state enum
enum WalletConnectionState {
  disconnected,
  connecting,
  connected,
  error,
}

/// Mock transaction model
class MockTransaction {

  MockTransaction({
    required this.type,
    required this.amount,
    required this.time,
    required this.status,
  });
  final String type;
  final String amount;
  final String time;
  final TransactionStatus status;
}

enum TransactionStatus {
  pending,
  completed,
  failed,
}

/// Extension for wallet connection state
extension WalletConnectionStateX on WalletConnectionState {
  bool get isConnected => this == WalletConnectionState.connected;
  bool get isConnecting => this == WalletConnectionState.connecting;
  bool get hasError => this == WalletConnectionState.error;
}
