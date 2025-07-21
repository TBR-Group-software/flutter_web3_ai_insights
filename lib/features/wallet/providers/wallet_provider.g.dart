// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletStateStreamHash() => r'641e2e7fe77310ba7ebd8e65b87c0a2f3dfb3919';

/// See also [walletStateStream].
@ProviderFor(walletStateStream)
final walletStateStreamProvider =
    AutoDisposeStreamProvider<WalletState>.internal(
      walletStateStream,
      name: r'walletStateStreamProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$walletStateStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletStateStreamRef = AutoDisposeStreamProviderRef<WalletState>;
String _$walletNotifierHash() => r'6325484345b5eafa79eb461c7096674a095b8a48';

/// See also [WalletNotifier].
@ProviderFor(WalletNotifier)
final walletNotifierProvider =
    AutoDisposeAsyncNotifierProvider<WalletNotifier, WalletState>.internal(
      WalletNotifier.new,
      name: r'walletNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$walletNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WalletNotifier = AutoDisposeAsyncNotifier<WalletState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
