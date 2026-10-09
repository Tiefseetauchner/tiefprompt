import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_chapter_provider.g.dart';

class Chapter {
  final String title;
  final double offset;

  Chapter({required this.title, required this.offset});
}

@riverpod
class AllChapter extends _$AllChapter {
  @override
  List<Chapter> build() {
    return [];
  }

  void setChapters(List<Chapter> chapters) {
    state = chapters;
  }
}
