import 'package:tiefprompt/providers/disabled_features.dart';
import 'package:tiefprompt/providers/feature_provider.dart';

class FossFeatures extends Features {
  @override
  DisabledFeatures build() {
    return DisabledFeatures([]);
  }
}
