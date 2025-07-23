import 'package:json_annotation/json_annotation.dart';

part 'token_balance.g.dart';

@JsonSerializable()
class TokenBalance {

  const TokenBalance({
    required this.symbol,
    required this.name,
    required this.contractAddress,
    required this.balance,
    required this.decimals,
    this.logoUri,
  });

  factory TokenBalance.fromJson(Map<String, dynamic> json) => _$TokenBalanceFromJson(json);
  final String symbol;
  final String name;
  final String contractAddress;
  final BigInt balance;
  final int decimals;
  final String? logoUri;
  Map<String, dynamic> toJson() => _$TokenBalanceToJson(this);

  TokenBalance copyWith({
    String? symbol,
    String? name,
    String? contractAddress,
    BigInt? balance,
    int? decimals,
    String? logoUri,
  }) {
    return TokenBalance(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      contractAddress: contractAddress ?? this.contractAddress,
      balance: balance ?? this.balance,
      decimals: decimals ?? this.decimals,
      logoUri: logoUri ?? this.logoUri,
    );
  }
} 
