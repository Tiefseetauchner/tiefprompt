import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiefprompt/providers/fonts_provider.dart';
import 'package:tiefprompt/ui/widgets/async_settings_builder.dart';
import 'package:tiefprompt/ui/widgets/safe_scaffold.dart';

class FontSettingsScreen extends ConsumerWidget {
  const FontSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fonts = ref.watch(fontsProvider);

    return AsyncSettingsBuilder(
      state: fonts,
      screenTitle: context.tr("SettingsScreen.FontSettings.Title"),
      builder: (ref, value) {
        final fontsList = value;

        return SafeScaffold(
          appBar: AppBar(
            title: Text(context.tr("SettingsScreen.FontSettings.Title")),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: fontsList.length,
                  itemBuilder: (context, index) {
                    final font = fontsList[index];
                    return ExpansionTile(
                      title: Text(
                        font.name,
                        style: TextStyle(fontFamily: font.name),
                      ),
                      subtitle: Text(
                        font.isBuiltIn
                            ? context.tr("SettingsScreen.FontSettings.BuiltIn")
                            : context.tr("SettingsScreen.FontSettings.Custom"),
                      ),
                      children: [
                        ...font.variants.map(
                          (e) => ListTile(
                            dense: true,
                            title: Text(
                              "Weight ${e.weight}; Style ${e.fontStyle.name}",
                              style: TextStyle(
                                fontFamily: font.name,
                                fontWeight: FontWeight(e.weight),
                                fontStyle: e.fontStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
