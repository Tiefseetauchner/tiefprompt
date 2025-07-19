// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tiefPromptRouterHash() => r'aab560feda389300c827077972c20cb2f5cfe8e1';

/// See also [TiefPromptRouter].
@ProviderFor(TiefPromptRouter)
final tiefPromptRouterProvider =
    AutoDisposeAsyncNotifierProvider<TiefPromptRouter, GoRouter>.internal(
      TiefPromptRouter.new,
      name: r'tiefPromptRouterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$tiefPromptRouterHash,
      dependencies: <ProviderOrFamily>[themesProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        themesProvider,
        ...?themesProvider.allTransitiveDependencies,
      },
    );

typedef _$TiefPromptRouter = AutoDisposeAsyncNotifier<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
