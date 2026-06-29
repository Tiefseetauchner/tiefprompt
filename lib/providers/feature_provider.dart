import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/providers/app_features.dart';

part 'feature_provider.g.dart';

@Riverpod(keepAlive: true)
class Features extends _$Features {
  @override
  AppFeatures build() {
    return AppFeatures([], FeatureKind.unverifiedBuild);
  }

  Future<bool> bootstrap() {
    throw UnimplementedError('bootstrap must be implemented in subclasses');
  }

  Future<bool> buyPro() {
    throw UnimplementedError('buyPro must be implemented in subclasses');
  }

  Future<bool> restorePurchase() {
    throw UnimplementedError(
      'restorePurchase must be implemented in subclasses',
    );
  }

  Widget getPurchaseScreen(DisabledFeatureScreenRouterExtra? extra) {
    throw UnimplementedError(
      'getPurchaseScreen must be implemented in subclasses',
    );
  }
}
