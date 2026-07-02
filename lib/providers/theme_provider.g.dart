// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Themes)
final themesProvider = ThemesProvider._();

final class ThemesProvider extends $AsyncNotifierProvider<Themes, ThemesState> {
  ThemesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themesProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[settingsProvider],
        $allTransitiveDependencies: <ProviderOrFamily>[
          ThemesProvider.$allTransitiveDependencies0,
        ],
      );

  static final $allTransitiveDependencies0 = settingsProvider;

  @override
  String debugGetCreateSourceHash() => _$themesHash();

  @$internal
  @override
  Themes create() => Themes();
}

String _$themesHash() => r'0d68cf156e496db88b00426880c03387234cd96a';

abstract class _$Themes extends $AsyncNotifier<ThemesState> {
  FutureOr<ThemesState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemesState>, ThemesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemesState>, ThemesState>,
              AsyncValue<ThemesState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
