import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web3_ai_assistant/services/binance_rest/models/simple_price.dart';
import 'package:web3_ai_assistant/services/binance_rest/models/ticker_24hr.dart';

part 'binance_rest_service.g.dart';

/// Retrofit API client for Binance REST endpoints
@RestApi(baseUrl: 'https://api.binance.com')
abstract class BinanceRestService {
  factory BinanceRestService(Dio dio, {String? baseUrl}) = _BinanceRestService;

  /// Get latest prices for symbols
  @GET('/api/v3/ticker/price')
  Future<List<SimplePrice>> getPrices({
    @Query('symbols') required String symbols,
  });

  /// Get 24hr ticker statistics for symbols
  @GET('/api/v3/ticker/24hr')
  Future<List<Ticker24hr>> getTicker24hr({
    @Query('symbols') required String symbols,
  });
}
