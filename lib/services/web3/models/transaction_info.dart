class TransactionInfo {
  const TransactionInfo({
    required this.hash,
    required this.from,
    required this.to,
    required this.value,
    required this.timestamp,
    required this.blockNumber,
    required this.gasUsed,
    required this.status,
    this.contractAddress,
    this.tokenTransfers = const [],
  });

  final String hash;
  final String from;
  final String to;
  final BigInt value;
  final DateTime timestamp;
  final int blockNumber;
  final BigInt gasUsed;
  final TransactionStatus status;
  final String? contractAddress;
  final List<TokenTransfer> tokenTransfers;
}

class TokenTransfer {
  const TokenTransfer({
    required this.tokenAddress,
    required this.from,
    required this.to,
    required this.value,
    required this.tokenSymbol,
    required this.tokenDecimals,
  });

  final String tokenAddress;
  final String from;
  final String to;
  final BigInt value;
  final String tokenSymbol;
  final int tokenDecimals;
}

enum TransactionStatus { pending, success, failed }
