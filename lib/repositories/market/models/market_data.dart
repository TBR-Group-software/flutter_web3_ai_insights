import 'package:json_annotation/json_annotation.dart';

part 'market_data.g.dart';

@JsonSerializable()
class MarketData {
  const MarketData({
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.high24h,
    required this.low24h,
    required this.volume24h,
    this.lastUpdated,
  });

  factory MarketData.fromJson(Map<String, dynamic> json) => _$MarketDataFromJson(json);
  
  final String symbol;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double high24h;
  final double low24h;
  final double volume24h;
  final DateTime? lastUpdated;
  
  Map<String, dynamic> toJson() => _$MarketDataToJson(this);
  
  MarketData copyWith({
    String? symbol,
    double? price,
    double? change24h,
    double? changePercent24h,
    double? high24h,
    double? low24h,
    double? volume24h,
    DateTime? lastUpdated,
  }) {
    return MarketData(
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

  bool get isPositive => changePercent24h >= 0;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  
  String get formattedChange => '${isPositive ? '+' : ''}${changePercent24h.toStringAsFixed(2)}%';
  
  String get formattedVolume {
    if (volume24h >= 1e9) {
      return '\$${(volume24h / 1e9).toStringAsFixed(2)}B';
    } else if (volume24h >= 1e6) {
      return '\$${(volume24h / 1e6).toStringAsFixed(2)}M';
    } else if (volume24h >= 1e3) {
      return '\$${(volume24h / 1e3).toStringAsFixed(2)}K';
    }
    return '\$${volume24h.toStringAsFixed(2)}';
  }
}
