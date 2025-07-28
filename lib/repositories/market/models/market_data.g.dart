// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketData _$MarketDataFromJson(Map<String, dynamic> json) => MarketData(
  symbol: json['symbol'] as String,
  price: (json['price'] as num).toDouble(),
  change24h: (json['change24h'] as num).toDouble(),
  changePercent24h: (json['changePercent24h'] as num).toDouble(),
  high24h: (json['high24h'] as num).toDouble(),
  low24h: (json['low24h'] as num).toDouble(),
  volume24h: (json['volume24h'] as num).toDouble(),
  lastUpdated:
      json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$MarketDataToJson(MarketData instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'change24h': instance.change24h,
      'changePercent24h': instance.changePercent24h,
      'high24h': instance.high24h,
      'low24h': instance.low24h,
      'volume24h': instance.volume24h,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
