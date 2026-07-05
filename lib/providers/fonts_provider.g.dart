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
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fontsHash();

  @$internal
  @override
  Fonts create() => Fonts();
}

String _$fontsHash() => r'7e552df3fecd2796ec288e47db176e31940a942a';

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
