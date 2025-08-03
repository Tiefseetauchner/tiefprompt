import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FeaturesUnverified extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(
      [
        Feature.appLanguage,
        Feature.appTheme,
        Feature.primaryAppColor,
        Feature.scrollSpeed,
        Feature.flipX,
        Feature.flipY,
        Feature.readingIndicatorBoxes,
        Feature.verticalMargins,
        Feature.verticalMarginFade,
        Feature.sideMargins,
        Feature.countdownTimer,
        Feature.prompterBackgroundColor,
        Feature.prompterTextColor,
        Feature.fontSize,
        Feature.textAlignment,
        Feature.fontFamily,
      ],
      FeatureKind.unverifiedBuild,
      null,
    );
  }

  @override
  Future<void> bootstrap() {
    // No bootstrap logic for unverified builds
    return Future.value();
  }
}
