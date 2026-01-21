// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tiefPromptRouterHash() => r'9b4fd867aaf8dae2fb0f7f4093884788f64b4d6b';

/// See also [TiefPromptRouter].
@ProviderFor(TiefPromptRouter)
final tiefPromptRouterProvider =
    NotifierProvider<TiefPromptRouter, GoRouter>.internal(
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

typedef _$TiefPromptRouter = Notifier<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
