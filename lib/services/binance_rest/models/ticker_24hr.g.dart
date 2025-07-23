// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker_24hr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticker24hr _$Ticker24hrFromJson(Map<String, dynamic> json) => Ticker24hr(
  symbol: json['symbol'] as String,
  lastPrice: json['lastPrice'] as String,
  priceChangePercent: json['priceChangePercent'] as String,
  highPrice: json['highPrice'] as String,
  lowPrice: json['lowPrice'] as String,
  volume: json['volume'] as String,
  closeTime: (json['closeTime'] as num).toInt(),
);

Map<String, dynamic> _$Ticker24hrToJson(Ticker24hr instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'lastPrice': instance.lastPrice,
      'priceChangePercent': instance.priceChangePercent,
      'highPrice': instance.highPrice,
      'lowPrice': instance.lowPrice,
      'volume': instance.volume,
      'closeTime': instance.closeTime,
    };
