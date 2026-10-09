import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_chapter_provider.g.dart';
part 'current_chapter_provider.freezed.dart';

@freezed
abstract class CurrentChapterState with _$CurrentChapterState {
  factory CurrentChapterState(String chapterText, double chapterOffset) =
      _CurrentChapterState;
}

@Riverpod(keepAlive: true)
class CurrentChapter extends _$CurrentChapter {
  @override
  CurrentChapterState? build() => null;

  void setChapter(String text, double offset) => state =
      state?.copyWith(chapterText: text, chapterOffset: offset) ??
      CurrentChapterState(text, offset);

  void clearChapter() => state = null;
}
