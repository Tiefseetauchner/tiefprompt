import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FeaturesFoss extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(kAllFeatures, FeatureKind.fossVersion);
  }

  @override
  Future<bool> bootstrap() {
    // No bootstrap logic for foss builds
    return Future.value(true);
  }

  @override
  Future<void> buyPro() {
    // No purchase logic for foss builds
    return Future.value();
  }

  @override
  Future<bool> restorePurchase() {
    // No restore logic for foss builds
    return Future.value(false);
  }
}
