import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiefprompt/core/constants.dart';

part 'app_features.freezed.dart';

@freezed
abstract class AppFeatures with _$AppFeatures {
  factory AppFeatures(List<Feature> features, FeatureKind featureKind) =
      _AppFeatures;
}
