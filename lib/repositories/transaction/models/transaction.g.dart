// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  hash: json['hash'] as String,
  from: json['from'] as String,
  to: json['to'] as String,
  value: json['value'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  blockNumber: (json['blockNumber'] as num).toInt(),
  status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
  type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
  tokenAddress: json['tokenAddress'] as String?,
  tokenSymbol: json['tokenSymbol'] as String?,
  tokenName: json['tokenName'] as String?,
  tokenDecimals: (json['tokenDecimals'] as num?)?.toInt(),
  gasUsed: json['gasUsed'] as String?,
  gasPrice: json['gasPrice'] as String?,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value,
      'timestamp': instance.timestamp.toIso8601String(),
      'blockNumber': instance.blockNumber,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'tokenAddress': instance.tokenAddress,
      'tokenSymbol': instance.tokenSymbol,
      'tokenName': instance.tokenName,
      'tokenDecimals': instance.tokenDecimals,
      'gasUsed': instance.gasUsed,
      'gasPrice': instance.gasPrice,
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
};

const _$TransactionTypeEnumMap = {
  TransactionType.sent: 'sent',
  TransactionType.received: 'received',
  TransactionType.swap: 'swap',
  TransactionType.contract: 'contract',
  TransactionType.unknown: 'unknown',
};
