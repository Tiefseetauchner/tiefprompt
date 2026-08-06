// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fonts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Fonts)
final fontsProvider = FontsProvider._();

final class FontsProvider
    extends $AsyncNotifierProvider<Fonts, List<TiefPromptFontsFile>> {
  FontsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fontsProvider',
        isAutoDispose: false,
        dependencies: <ProviderOrFamily>[
          settingsProvider,
          appDatabaseManagerProvider,
        ],
        $allTransitiveDependencies: <ProviderOrFamily>[
          FontsProvider.$allTransitiveDependencies0,
          FontsProvider.$allTransitiveDependencies1,
        ],
      );

  static final $allTransitiveDependencies0 = settingsProvider;
  static final $allTransitiveDependencies1 = appDatabaseManagerProvider;

  @override
  String debugGetCreateSourceHash() => _$fontsHash();

  @$internal
  @override
  Fonts create() => Fonts();
}

String _$fontsHash() => r'e41abba0e894938767b2c2fe45112a6d411c1449';

abstract class _$Fonts extends $AsyncNotifier<List<TiefPromptFontsFile>> {
  FutureOr<List<TiefPromptFontsFile>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TiefPromptFontsFile>>,
              List<TiefPromptFontsFile>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TiefPromptFontsFile>>,
                List<TiefPromptFontsFile>
              >,
              AsyncValue<List<TiefPromptFontsFile>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
