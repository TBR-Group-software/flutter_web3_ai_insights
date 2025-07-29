// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$portfolioStreamHash() => r'8164863a0f92b5abcd4ff36092c825adc7e3c6b7';

/// Stream provider for real-time portfolio updates
/// Combines initial data fetch with WebSocket price updates
///
/// Copied from [portfolioStream].
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

/// Computed provider to check if portfolio is empty
///
/// Copied from [isPortfolioEmpty].
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
    r'2602af82785259f1ad276af9f5c3ac61bd5ebe75';

/// Computes total portfolio value in USD
///
/// Copied from [totalPortfolioValue].
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
    r'1036b3a432196eff914f4ea99d76a1b4f10259f6';

/// Computes total portfolio change in USD (24h)
///
/// Copied from [totalPortfolioChange].
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

/// Computes total portfolio change percentage (24h)
///
/// Copied from [totalPortfolioChangePercent].
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

/// Returns top 5 performing tokens by percentage change
///
/// Copied from [topPerformingTokens].
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

/// Returns top 10 tokens by total USD value
///
/// Copied from [topValueTokens].
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
String _$portfolioNotifierHash() => r'4c2e0d2d10f64919add481eba5f024f19fecd324';

/// State notifier for portfolio management
/// Fetches token balances and subscribes to real-time price updates
///
/// Copied from [PortfolioNotifier].
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
