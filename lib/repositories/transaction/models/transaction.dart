import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  const Transaction({
    required this.hash,
    required this.from,
    required this.to,
    required this.value,
    required this.timestamp,
    required this.blockNumber,
    required this.status,
    required this.type,
    this.tokenAddress,
    this.tokenSymbol,
    this.tokenName,
    this.tokenDecimals,
    this.gasUsed,
    this.gasPrice,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  
  final String hash;
  final String from;
  final String to;
  final String value;
  final DateTime timestamp;
  final int blockNumber;
  final TransactionStatus status;
  final TransactionType type;
  final String? tokenAddress;
  final String? tokenSymbol;
  final String? tokenName;
  final int? tokenDecimals;
  final String? gasUsed;
  final String? gasPrice;
  
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
  
  Transaction copyWith({
    String? hash,
    String? from,
    String? to,
    String? value,
    DateTime? timestamp,
    int? blockNumber,
    TransactionStatus? status,
    TransactionType? type,
    String? tokenAddress,
    String? tokenSymbol,
    String? tokenName,
    int? tokenDecimals,
    String? gasUsed,
    String? gasPrice,
  }) {
    return Transaction(
      hash: hash ?? this.hash,
      from: from ?? this.from,
      to: to ?? this.to,
      value: value ?? this.value,
      timestamp: timestamp ?? this.timestamp,
      blockNumber: blockNumber ?? this.blockNumber,
      status: status ?? this.status,
      type: type ?? this.type,
      tokenAddress: tokenAddress ?? this.tokenAddress,
      tokenSymbol: tokenSymbol ?? this.tokenSymbol,
      tokenName: tokenName ?? this.tokenName,
      tokenDecimals: tokenDecimals ?? this.tokenDecimals,
      gasUsed: gasUsed ?? this.gasUsed,
      gasPrice: gasPrice ?? this.gasPrice,
    );
  }

  String get displayAmount {
    if (tokenSymbol != null && value.isNotEmpty) {
      // Format token amount with decimals
      if (tokenDecimals != null && tokenDecimals! > 0) {
        final bigIntValue = BigInt.parse(value);
        final divisor = BigInt.from(10).pow(tokenDecimals!);
        final doubleValue = bigIntValue / divisor;
        return '${doubleValue.toStringAsFixed(4)} $tokenSymbol';
      }
      return '$value $tokenSymbol';
    }
    // Format ETH amount (18 decimals)
    try {
      final bigIntValue = BigInt.parse(value);
      final ethValue = bigIntValue / BigInt.from(10).pow(18);
      return '${ethValue.toStringAsFixed(4)} ETH';
    } catch (e) {
      return '0 ETH';
    }
  }

  String get typeLabel {
    switch (type) {
      case TransactionType.sent:
        return 'Sent';
      case TransactionType.received:
        return 'Received';
      case TransactionType.swap:
        return 'Swap';
      case TransactionType.contract:
        return 'Contract';
      case TransactionType.unknown:
        return 'Transfer';
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

@JsonEnum()
enum TransactionStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

@JsonEnum()
enum TransactionType {
  @JsonValue('sent')
  sent,
  @JsonValue('received')
  received,
  @JsonValue('swap')
  swap,
  @JsonValue('contract')
  contract,
  @JsonValue('unknown')
  unknown,
}
