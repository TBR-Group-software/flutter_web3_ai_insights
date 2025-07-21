// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$portfolioStreamHash() => r'0af758a91f0257cb40fa3558035b3078a208fdd9';

/// See also [portfolioStream].
@ProviderFor(portfolioStream)
final portfolioStreamProvider =
    AutoDisposeStreamProvider<List<PortfolioToken>>.internal(
      portfolioStream,
      name: r'portfolioStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$portfolioStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PortfolioStreamRef = AutoDisposeStreamProviderRef<List<PortfolioToken>>;
String _$isPortfolioEmptyHash() => r'483dc286d7f5291b0335f5875ea50933179560b7';

/// See also [isPortfolioEmpty].
@ProviderFor(isPortfolioEmpty)
final isPortfolioEmptyProvider = AutoDisposeProvider<bool>.internal(
  isPortfolioEmpty,
  name: r'isPortfolioEmptyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$isPortfolioEmptyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsPortfolioEmptyRef = AutoDisposeProviderRef<bool>;
String _$totalPortfolioValueHash() =>
    r'9a46dd5287fe47125bfa8dc551e0b2ed16102b76';

/// See also [totalPortfolioValue].
@ProviderFor(totalPortfolioValue)
final totalPortfolioValueProvider = AutoDisposeProvider<double>.internal(
  totalPortfolioValue,
  name: r'totalPortfolioValueProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totalPortfolioValueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalPortfolioValueRef = AutoDisposeProviderRef<double>;
String _$totalPortfolioChangeHash() =>
    r'aa27dd235f6b86df366446261f7be2c48021defa';

/// See also [totalPortfolioChange].
@ProviderFor(totalPortfolioChange)
final totalPortfolioChangeProvider = AutoDisposeProvider<double>.internal(
  totalPortfolioChange,
  name: r'totalPortfolioChangeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$totalPortfolioChangeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalPortfolioChangeRef = AutoDisposeProviderRef<double>;
String _$totalPortfolioChangePercentHash() =>
    r'a3751a2475789a250a514b448ce3608457abae41';

/// See also [totalPortfolioChangePercent].
@ProviderFor(totalPortfolioChangePercent)
final totalPortfolioChangePercentProvider =
    AutoDisposeProvider<double>.internal(
      totalPortfolioChangePercent,
      name: r'totalPortfolioChangePercentProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$totalPortfolioChangePercentHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalPortfolioChangePercentRef = AutoDisposeProviderRef<double>;
String _$topPerformingTokensHash() =>
    r'f0db4690b236a84e69ea43f5149dfb81994987c0';

/// See also [topPerformingTokens].
@ProviderFor(topPerformingTokens)
final topPerformingTokensProvider =
    AutoDisposeProvider<List<PortfolioToken>>.internal(
      topPerformingTokens,
      name: r'topPerformingTokensProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$topPerformingTokensHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TopPerformingTokensRef = AutoDisposeProviderRef<List<PortfolioToken>>;
String _$topValueTokensHash() => r'f51e3073cf2c2edbb72755cbb03514542ab4fb6c';

/// See also [topValueTokens].
@ProviderFor(topValueTokens)
final topValueTokensProvider =
    AutoDisposeProvider<List<PortfolioToken>>.internal(
      topValueTokens,
      name: r'topValueTokensProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$topValueTokensHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TopValueTokensRef = AutoDisposeProviderRef<List<PortfolioToken>>;
String _$portfolioNotifierHash() => r'9809cccedc684c5ffe0641856d6bc40cdc276d72';

/// See also [PortfolioNotifier].
@ProviderFor(PortfolioNotifier)
final portfolioNotifierProvider = AutoDisposeAsyncNotifierProvider<
  PortfolioNotifier,
  List<PortfolioToken>
>.internal(
  PortfolioNotifier.new,
  name: r'portfolioNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$portfolioNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PortfolioNotifier = AutoDisposeAsyncNotifier<List<PortfolioToken>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
