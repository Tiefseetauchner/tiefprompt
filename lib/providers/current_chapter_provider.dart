import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_chapter_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentChapter extends _$CurrentChapter {
  @override
  String? build() => null;

  void setValue(String? value) => state = value;
}
