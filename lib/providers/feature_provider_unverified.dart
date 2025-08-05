import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FeaturesUnverified extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(kAllFeatures, FeatureKind.unverifiedBuild);
  }

  @override
  Future<bool> bootstrap() {
    // No bootstrap logic for unverified builds
    return Future.value(true);
  }

  @override
  Future<void> buyPro() {
    // No purchase logic for unverified builds
    return Future.value();
  }
}
