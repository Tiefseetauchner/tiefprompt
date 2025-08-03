import 'package:tiefprompt/core/constants.dart';

abstract class IFeatureSelector {
  Future<List<Feature>> getDisabledFeatures();
}
