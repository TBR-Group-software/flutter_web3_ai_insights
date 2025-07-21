// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$web3ServiceHash() => r'ad2c18c2b0d3f46b0dfdfdb1ccb23529eaf0eb94';

/// See also [web3Service].
@ProviderFor(web3Service)
final web3ServiceProvider = AutoDisposeProvider<Web3Service>.internal(
  web3Service,
  name: r'web3ServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$web3ServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef Web3ServiceRef = AutoDisposeProviderRef<Web3Service>;
String _$marketDataServiceHash() => r'eaaa5ba68701743b75f479f13088308d0389ce5e';

/// See also [marketDataService].
@ProviderFor(marketDataService)
final marketDataServiceProvider =
    AutoDisposeProvider<MarketDataService>.internal(
      marketDataService,
      name: r'marketDataServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$marketDataServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MarketDataServiceRef = AutoDisposeProviderRef<MarketDataService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
