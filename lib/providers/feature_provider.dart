import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/providers/disabled_features.dart';

part 'feature_provider.g.dart';

@riverpod
class Features extends _$Features {
  @override
  DisabledFeatures build() {
    return DisabledFeatures([]);
  }
}
