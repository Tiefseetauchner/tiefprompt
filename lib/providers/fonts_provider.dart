import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/fonts.dart';
import 'package:tiefprompt/models/custom_font_model.dart';
import 'package:tiefprompt/providers/database_provider.dart';

part 'fonts_provider.g.dart';

@Riverpod(keepAlive: true)
class Fonts extends _$Fonts {
  @override
  Future<List<TiefPromptFontsFile>> build() async {
    final customFonts = await ref
        .read(databaseManagersProvider)
        .customFontModel
        .asyncMap(CustomFontModelHelpers.customFontModelToFontFile)
        .get();

    final allFonts = [...kAvailableFonts, ...customFonts];

    for (final font in allFonts) {
      registerFont(font);
    }

    return allFonts;
  }
}
