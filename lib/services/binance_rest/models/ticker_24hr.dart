import 'package:json_annotation/json_annotation.dart';

part 'ticker_24hr.g.dart';

@JsonSerializable()
class Ticker24hr {

  const Ticker24hr({
    required this.symbol,
    required this.lastPrice,
    required this.priceChangePercent,
    required this.highPrice,
    required this.lowPrice,
    required this.volume,
    required this.closeTime,
  });

  factory Ticker24hr.fromJson(Map<String, dynamic> json) => _$Ticker24hrFromJson(json);
  final String symbol;
  final String lastPrice;
  final String priceChangePercent;
  final String highPrice;
  final String lowPrice;
  final String volume;
  final int closeTime;
  Map<String, dynamic> toJson() => _$Ticker24hrToJson(this);
} 
