// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenBalance _$TokenBalanceFromJson(Map<String, dynamic> json) => TokenBalance(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  contractAddress: json['contractAddress'] as String,
  balance: BigInt.parse(json['balance'] as String),
  decimals: (json['decimals'] as num).toInt(),
  logoUri: json['logoUri'] as String?,
);

Map<String, dynamic> _$TokenBalanceToJson(TokenBalance instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'contractAddress': instance.contractAddress,
      'balance': instance.balance.toString(),
      'decimals': instance.decimals,
      'logoUri': instance.logoUri,
    };
