// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_chapter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentChapter)
final currentChapterProvider = CurrentChapterProvider._();

final class CurrentChapterProvider
    extends $NotifierProvider<CurrentChapter, CurrentChapterState?> {
  CurrentChapterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentChapterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentChapterHash();

  @$internal
  @override
  CurrentChapter create() => CurrentChapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrentChapterState? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrentChapterState?>(value),
    );
  }
}

String _$currentChapterHash() => r'a23d39b42b0920a0d7966d2a1bc1d6ced15b8380';

abstract class _$CurrentChapter extends $Notifier<CurrentChapterState?> {
  CurrentChapterState? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CurrentChapterState?, CurrentChapterState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CurrentChapterState?, CurrentChapterState?>,
              CurrentChapterState?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
