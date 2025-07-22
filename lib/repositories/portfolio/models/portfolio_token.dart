import 'package:json_annotation/json_annotation.dart';

part 'portfolio_token.g.dart';

@JsonSerializable()
class PortfolioToken {

  const PortfolioToken({
    required this.symbol,
    required this.name,
    required this.contractAddress,
    required this.balance,
    required this.decimals,
    required this.price,
    required this.change24h,
    required this.changePercent24h,
    required this.totalValue,
    this.logoUri,
    this.lastUpdated,
  });

  factory PortfolioToken.fromJson(Map<String, dynamic> json) => _$PortfolioTokenFromJson(json);
  final String symbol;
  final String name;
  final String contractAddress;
  final double balance;
  final int decimals;
  final double price;
  final double change24h;
  final double changePercent24h;
  final double totalValue;
  final String? logoUri;
  final DateTime? lastUpdated;
  Map<String, dynamic> toJson() => _$PortfolioTokenToJson(this);

  PortfolioToken copyWith({
    String? symbol,
    String? name,
    String? contractAddress,
    double? balance,
    int? decimals,
    double? price,
    double? change24h,
    double? changePercent24h,
    double? totalValue,
    String? logoUri,
    DateTime? lastUpdated,
  }) {
    return PortfolioToken(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      contractAddress: contractAddress ?? this.contractAddress,
      balance: balance ?? this.balance,
      decimals: decimals ?? this.decimals,
      price: price ?? this.price,
      change24h: change24h ?? this.change24h,
      changePercent24h: changePercent24h ?? this.changePercent24h,
      totalValue: totalValue ?? this.totalValue,
      logoUri: logoUri ?? this.logoUri,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
} 
