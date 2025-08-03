import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiefprompt/core/constants.dart';

part 'disabled_features.freezed.dart';

@freezed
abstract class DisabledFeatures with _$DisabledFeatures {
  factory DisabledFeatures(List<Feature> features) = _DisabledFeatures;
}
