import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/disabled_feature_screen_state.dart';
import 'package:tiefprompt/core/utilities.dart';

class FeatureVersionPopupContent extends ConsumerWidget {
  final String featureName;
  final String featureExplanation;

  final List<Widget> actions;

  const FeatureVersionPopupContent({
    super.key,
    required this.featureName,
    required this.featureExplanation,
    required this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          featureName,
          textScaler: TextScaler.linear(1.5),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(featureExplanation),
        ...actions,
      ],
    );
  }
}

class ProFeatureVersionPopupContent extends StatelessWidget {
  const ProFeatureVersionPopupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureVersionPopupContent(
      featureName: context.tr("HomeScreen.PaidVersion"),
      featureExplanation: context.tr("HomeScreen.PaidVersion_Explanation"),
      actions: [
        ElevatedButton(
          onPressed: () => launchUrlFromString(kRepoUrl),
          child: Text(kRepoUrl),
        ),
      ],
    );
  }
}

class FreeFeatureVersionPopupContent extends StatelessWidget {
  const FreeFeatureVersionPopupContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureVersionPopupContent(
      featureName: context.tr("HomeScreen.FreeVersion"),
      featureExplanation: context.tr("HomeScreen.FreeVersion_Explanation"),
      actions: [
        ElevatedButton(
          onPressed: () => context.push(
            "/disabledfeature",
            extra: DisabledFeatureScreenRouterExtra(feature: null),
          ),
          child: Text(context.tr("HomeScreen.FreeVersion_BuyPro")),
        ),
        OutlinedButton(
          onPressed: () => launchUrlFromString(kRepoUrl),
          child: Text(kRepoUrl),
        ),
      ],
    );
  }
}
