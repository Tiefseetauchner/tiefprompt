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
    extends
        $NotifierProvider<AllChapter, List<({double offset, String title})>> {
  AllChapterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allChapterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allChapterHash();

  @$internal
  @override
  AllChapter create() => AllChapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<({double offset, String title})> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<List<({double offset, String title})>>(value),
    );
  }
}

String _$allChapterHash() => r'd799a6684890c229ac5c2804c1481398279bede9';

abstract class _$AllChapter
    extends $Notifier<List<({double offset, String title})>> {
  List<({double offset, String title})> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              List<({double offset, String title})>,
              List<({double offset, String title})>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<({double offset, String title})>,
                List<({double offset, String title})>
              >,
              List<({double offset, String title})>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
