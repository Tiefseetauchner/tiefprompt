import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_provider.g.dart';

@riverpod
class BannerMessage extends _$BannerMessage {
  @override
  String? build() => null;
  void set(String? msg) => state = msg;
}
