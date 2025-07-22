// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioToken _$PortfolioTokenFromJson(Map<String, dynamic> json) =>
    PortfolioToken(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      contractAddress: json['contractAddress'] as String,
      balance: (json['balance'] as num).toDouble(),
      decimals: (json['decimals'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      change24h: (json['change24h'] as num).toDouble(),
      changePercent24h: (json['changePercent24h'] as num).toDouble(),
      totalValue: (json['totalValue'] as num).toDouble(),
      logoUri: json['logoUri'] as String?,
      lastUpdated:
          json['lastUpdated'] == null
              ? null
              : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$PortfolioTokenToJson(PortfolioToken instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'contractAddress': instance.contractAddress,
      'balance': instance.balance,
      'decimals': instance.decimals,
      'price': instance.price,
      'change24h': instance.change24h,
      'changePercent24h': instance.changePercent24h,
      'totalValue': instance.totalValue,
      'logoUri': instance.logoUri,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
