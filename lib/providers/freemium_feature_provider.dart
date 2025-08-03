import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/providers/disabled_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FreemiumFeatures extends Features {
  @override
  DisabledFeatures build() {
    return DisabledFeatures(Feature.values);
  }
}
