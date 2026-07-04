import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/core/utilities.dart';
import 'package:tiefprompt/providers/app_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';
import 'package:tiefprompt/ui/screens/no_purchase_available_screen.dart';
import 'package:tiefprompt/ui/widgets/feature_version_popup_content.dart';

class FeaturesFoss extends Features {
  @override
  AppFeatures build() {
    return AppFeatures(
      kAllFeatures,
      FeatureKind.fossVersion,
      "HomeScreen.FossVersion",
    );
  }

  @override
  Future<bool> bootstrap() {
    // No bootstrap logic for foss builds
    return Future.value(true);
  }

  @override
  Future<bool> buyPro() {
    // No purchase logic for foss builds
    return Future.value(false);
  }

  @override
  Future<bool> restorePurchase() {
    // No restore logic for foss builds
    return Future.value(false);
  }

  @override
  Widget getPurchaseScreen(DisabledFeatureScreenRouterExtra? extra) {
    // No purchases available for foss builds
    return NoPurchaseAvailableScreen();
  }

  @override
  Widget Function(BuildContext) getFeaturePopup() {
    return (context) => FeatureVersionPopupContent(
      featureName: context.tr("HomeScreen.FossVersion"),
      featureExplanation: context.tr("HomeScreen.FossVersion_Explanation"),
      actions: [
        ElevatedButton(
          onPressed: () => launchUrlFromString(kRepoUrl),
          child: Text(kRepoUrl),
        ),
        OutlinedButton(
          onPressed: () => launchUrlFromString(kDonationUrl),
          child: Text(kDonationUrl),
        ),
      ],
    );
  }
}
