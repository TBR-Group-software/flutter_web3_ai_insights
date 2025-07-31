// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_insights_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quickInsightHash() => r'3d1acb47a59a7ae5034ba2defbe4cac71f6ecb12';

/// See also [quickInsight].
@ProviderFor(quickInsight)
final quickInsightProvider = AutoDisposeFutureProvider<String>.internal(
  quickInsight,
  name: r'quickInsightProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quickInsightHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuickInsightRef = AutoDisposeFutureProviderRef<String>;
String _$canGenerateAnalysisHash() =>
    r'088b8424bcbaae06766e040ef64e01762313690c';

/// See also [canGenerateAnalysis].
@ProviderFor(canGenerateAnalysis)
final canGenerateAnalysisProvider = AutoDisposeProvider<bool>.internal(
  canGenerateAnalysis,
  name: r'canGenerateAnalysisProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$canGenerateAnalysisHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CanGenerateAnalysisRef = AutoDisposeProviderRef<bool>;
String _$aiInsightsHash() => r'e589167e1b6a3025029fc0c71d55de7f54a68e62';

/// Main provider for AI insights feature
/// Manages analysis generation and history navigation
///
/// Copied from [AiInsights].
@ProviderFor(AiInsights)
final aiInsightsProvider =
    AsyncNotifierProvider<AiInsights, AiInsightsState>.internal(
      AiInsights.new,
      name: r'aiInsightsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$aiInsightsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AiInsights = AsyncNotifier<AiInsightsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
