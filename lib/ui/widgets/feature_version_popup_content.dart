import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
