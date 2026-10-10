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
  Override overrideWithValue(List<Chapter> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Chapter>>(value),
    );
  }
}

String _$allChapterHash() => r'cdcebbeacf7b09cf24e3a28d226444225fd1733c';

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
