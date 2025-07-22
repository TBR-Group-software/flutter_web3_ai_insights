import 'package:json_annotation/json_annotation.dart';

part 'simple_price.g.dart';

@JsonSerializable()
class SimplePrice {

  const SimplePrice({
    required this.symbol,
    required this.price,
  });

  factory SimplePrice.fromJson(Map<String, dynamic> json) => _$SimplePriceFromJson(json);
  final String symbol;
  final String price;
  Map<String, dynamic> toJson() => _$SimplePriceToJson(this);
} 
