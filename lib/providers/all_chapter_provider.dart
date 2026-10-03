import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_chapter_provider.g.dart';

@Riverpod(keepAlive: true)
class AllChapter extends _$AllChapter {
  @override
  List<({String title, double offset})> build() {
    return [];
  }

  void setChapters(List<({String title, double offset})> chapters) {
    state = chapters;
  }
}
