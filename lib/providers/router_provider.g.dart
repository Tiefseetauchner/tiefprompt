// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TiefPromptRouter)
final tiefPromptRouterProvider = TiefPromptRouterProvider._();

final class TiefPromptRouterProvider
    extends $NotifierProvider<TiefPromptRouter, GoRouter> {
  TiefPromptRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tiefPromptRouterProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[themesProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          TiefPromptRouterProvider.$allTransitiveDependencies0,
          TiefPromptRouterProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = themesProvider;
  static final $allTransitiveDependencies1 =
      ThemesProvider.$allTransitiveDependencies0;

  @override
  String debugGetCreateSourceHash() => _$tiefPromptRouterHash();

  @$internal
  @override
  TiefPromptRouter create() => TiefPromptRouter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$tiefPromptRouterHash() => r'fa7deab69993b93ec5d21866e2906b4bcf97d85d';

abstract class _$TiefPromptRouter extends $Notifier<GoRouter> {
  GoRouter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<GoRouter, GoRouter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoRouter, GoRouter>,
              GoRouter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
