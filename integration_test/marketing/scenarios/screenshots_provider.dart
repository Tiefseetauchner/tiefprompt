import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screenshots_provider.g.dart';

@Riverpod(keepAlive: true)
class Screenshots extends _$Screenshots {
  @override
  List<(String, List<int>)> build() {
    return [];
  }

  void addScreenshot(String name, List<int> bytes) {
    state = [...state, (name, bytes)];
  }
}
