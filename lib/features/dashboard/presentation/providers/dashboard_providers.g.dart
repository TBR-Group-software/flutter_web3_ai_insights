// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketOverviewHash() => r'b2b3e04afff44f1366710e3a6ac08cb737f28e41';

/// Market overview provider - fetches real market data
///
/// Copied from [marketOverview].
@ProviderFor(marketOverview)
final marketOverviewProvider =
    AutoDisposeFutureProvider<List<MarketData>>.internal(
      marketOverview,
      name: r'marketOverviewProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$marketOverviewHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MarketOverviewRef = AutoDisposeFutureProviderRef<List<MarketData>>;
String _$marketOverviewStreamHash() =>
    r'981d277857e2ee5c0294f0c331f1f40de8091887';

/// Market overview stream provider - provides real-time market data updates
///
/// Copied from [marketOverviewStream].
@ProviderFor(marketOverviewStream)
final marketOverviewStreamProvider =
    AutoDisposeStreamProvider<List<MarketData>>.internal(
      marketOverviewStream,
      name: r'marketOverviewStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$marketOverviewStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MarketOverviewStreamRef =
    AutoDisposeStreamProviderRef<List<MarketData>>;
String _$recentTransactionsHash() =>
    r'9bf911c4c7231ef31d7a46b1b02ecf8feb3914ff';

/// Recent transactions provider - fetches real transaction data
///
/// Copied from [recentTransactions].
@ProviderFor(recentTransactions)
final recentTransactionsProvider =
    AutoDisposeFutureProvider<List<Transaction>>.internal(
      recentTransactions,
      name: r'recentTransactionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$recentTransactionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentTransactionsRef = AutoDisposeFutureProviderRef<List<Transaction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
