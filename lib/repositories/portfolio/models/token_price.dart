import 'package:json_annotation/json_annotation.dart';

part 'token_price.g.dart';

@JsonSerializable()
class TokenPrice {
  const TokenPrice({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.high24h,
    required this.low24h,
    required this.volume24h,
    required this.lastUpdated,
  });

  factory TokenPrice.fromJson(Map<String, dynamic> json) => _$TokenPriceFromJson(json);
  final String symbol;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double high24h;
  final double low24h;
  final double volume24h;
  final DateTime lastUpdated;
  Map<String, dynamic> toJson() => _$TokenPriceToJson(this);

  TokenPrice copyWith({
    String? symbol,
    double? price,
    double? change24h,
    double? changePercent24h,
    double? high24h,
    double? low24h,
    double? volume24h,
    DateTime? lastUpdated,
  }) {
    return TokenPrice(
      symbol: symbol ?? this.symbol,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      changePercent24h: changePercent24h ?? this.changePercent24h,
      high24h: high24h ?? this.high24h,
      low24h: low24h ?? this.low24h,
      volume24h: volume24h ?? this.volume24h,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
