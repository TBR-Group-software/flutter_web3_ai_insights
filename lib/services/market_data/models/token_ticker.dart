import 'package:json_annotation/json_annotation.dart';

part 'token_ticker.g.dart';

@JsonSerializable()
class TokenTicker {

  const TokenTicker({
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.high,
    required this.low,
    required this.volume,
    required this.eventTime,
  });

  factory TokenTicker.fromJson(Map<String, dynamic> json) => _$TokenTickerFromJson(json);
  @JsonKey(name: 's')
  final String symbol;
  
  @JsonKey(name: 'c')
  final String price;
  
  @JsonKey(name: 'P')
  final String changePercent;
  
  @JsonKey(name: 'h')
  final String high;
  
  @JsonKey(name: 'l')
  final String low;
  
  @JsonKey(name: 'q')
  final String volume;
  
  @JsonKey(name: 'E')
  final int eventTime;
  Map<String, dynamic> toJson() => _$TokenTickerToJson(this);

  TokenTicker copyWith({
    String? symbol,
    String? price,
    String? changePercent,
    String? high,
    String? low,
    String? volume,
    int? eventTime,
  }) {
    return TokenTicker(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      changePercent: changePercent ?? this.changePercent,
      high: high ?? this.high,
      low: low ?? this.low,
      volume: volume ?? this.volume,
      eventTime: eventTime ?? this.eventTime,
    );
  }
} 
