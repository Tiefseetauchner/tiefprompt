import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';

part 'feature_provider.g.dart';

@riverpod
class Features extends _$Features {
  @override
  AppFeatures build() {
    return AppFeatures([], FeatureKind.unverifiedBuild, null);
  }

  Future<void> bootstrap() {
    throw UnimplementedError('bootstrap must be implemented in subclasses');
  }
}
