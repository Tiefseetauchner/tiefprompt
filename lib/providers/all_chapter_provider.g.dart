// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_chapter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AllChapter)
final allChapterProvider = AllChapterProvider._();

final class AllChapterProvider
    extends $NotifierProvider<AllChapter, List<Chapter>> {
  AllChapterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allChapterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allChapterHash();

  @$internal
  @override
  AllChapter create() => AllChapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Chapter> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Chapter>>(value),
    );
  }
}

String _$allChapterHash() => r'605b05f58d372dcca6ae076dfc61012f533b440b';

abstract class _$AllChapter extends $Notifier<List<Chapter>> {
  List<Chapter> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Chapter>, List<Chapter>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Chapter>, List<Chapter>>,
              List<Chapter>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
