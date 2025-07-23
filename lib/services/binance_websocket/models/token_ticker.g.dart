// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_ticker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenTicker _$TokenTickerFromJson(Map<String, dynamic> json) => TokenTicker(
  symbol: json['s'] as String,
  price: json['c'] as String,
  changePercent: json['P'] as String,
  high: json['h'] as String,
  low: json['l'] as String,
  volume: json['q'] as String,
  eventTime: (json['E'] as num).toInt(),
);

Map<String, dynamic> _$TokenTickerToJson(TokenTicker instance) =>
    <String, dynamic>{
      's': instance.symbol,
      'c': instance.price,
      'P': instance.changePercent,
      'h': instance.high,
      'l': instance.low,
      'q': instance.volume,
      'E': instance.eventTime,
    };
