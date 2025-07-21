class WalletError implements Exception {

  WalletError({
    required this.message,
    this.code,
    this.originalError,
  });

  factory WalletError.notInstalled() {
    return WalletError(
      message: 'MetaMask is not installed. Please install the MetaMask browser extension.',
      code: 'METAMASK_NOT_INSTALLED',
    );
  }

  factory WalletError.connectionFailed(dynamic error) {
    return WalletError(
      message: 'Failed to connect wallet',
      code: 'CONNECTION_FAILED',
      originalError: error,
    );
  }

  factory WalletError.userRejected() {
    return WalletError(
      message: 'User rejected the connection request',
      code: 'USER_REJECTED',
    );
  }

  factory WalletError.networkError(dynamic error) {
    return WalletError(
      message: 'Network error occurred',
      code: 'NETWORK_ERROR',
      originalError: error,
    );
  }
  final String message;
  final String? code;
  final dynamic originalError;

  @override
  String toString() => message;
}