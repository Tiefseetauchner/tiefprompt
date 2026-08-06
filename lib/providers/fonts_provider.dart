import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tiefprompt/core/constants.dart';
import 'package:tiefprompt/core/fonts.dart';
import 'package:tiefprompt/models/custom_font_model.dart';
import 'package:tiefprompt/models/custom_font_model.drift.dart';
import 'package:tiefprompt/providers/database_provider.dart';
import 'package:tiefprompt/providers/settings_provider.dart';
import 'package:tiefprompt/providers/talker_provider.dart';

part 'fonts_provider.g.dart';

@Riverpod(keepAlive: true, dependencies: [Settings, AppDatabaseManager])
class Fonts extends _$Fonts {
  @override
  Future<List<TiefPromptFontsFile>> build() async {
    final customFonts = await _getFontFilesFromDatabase();

    final allFonts = [...kAvailableFonts, ...customFonts];

    for (final font in allFonts) {
      registerFont(font, ref.read(talkerProvider));
    }

    await _ensureSelectedFontExists(allFonts);

    return allFonts;
  }

  Future<void> addFont(TiefPromptFontsFile font) async {
    final finalFont = _getMergedFont(font);

    await _saveFontToDatabase(finalFont);
    await _updateStateWithFont(finalFont);
    registerFont(finalFont, ref.read(talkerProvider));
  }

  // NOTE: This method is not yet required but left for future expansion.
  // Future<void> removeFont(TiefPromptFontsFile font) async {}

  Future<void> removeFontVariant(
    TiefPromptFontsFile font,
    TiefPromptFontsVariant variant,
  ) async {
    final updatedFont = font.copyWith(
      variants: font.variants.where(_allOtherVariantsFilter(variant)).toList(),
    );

    await _updateStateWithFont(updatedFont);

    await _removeEmptyFontIfNoVariantsLeft(updatedFont);

    final idToDelete = await _getVariantIdFromDatabase(font.name, variant);

    await _deleteFontVariantFromDatabase(idToDelete, variant);

    state.whenData((fonts) => _ensureSelectedFontExists(fonts));
  }

  Future<void> updateFont(TiefPromptFontsFile font, String name) async {
    if (_fontNameExists(name)) {
      throw Exception('Font with name $name already exists');
    }

    final fontWithNewName = font.copyWith(name: name);

    await _saveFontToDatabase(fontWithNewName);
    await _removeFontFamilyFromDatabase(font);

    state = state.whenData(
      (fonts) => [...fonts.where((f) => f.name != font.name), fontWithNewName],
    );

    registerFont(fontWithNewName, ref.read(talkerProvider));
  }

  Future<void> moveFontVariant(
    String fontName,
    TiefPromptFontsVariant variant,
    String newFontName,
  ) async {
    final originFontFile = _getFontByName(fontName);
    final variantToMove = _getVariantFromFont(originFontFile, variant);

    final newFontFile = state.requireValue
        .where((f) => f.name == newFontName)
        .singleOrNull;

    if (newFontFile == null) {
      throw Exception('Target font $newFontName not found');
    }

    if (newFontFile.isBuiltIn) {
      throw Exception('Cannot move variant to a built-in font');
    }

    final updatedOriginFontFile = originFontFile.copyWith(
      variants: originFontFile.variants
          .where((v) => v != variantToMove)
          .toList(),
    );

    await _updateStateWithFont(updatedOriginFontFile);

    await _removeEmptyFontIfNoVariantsLeft(updatedOriginFontFile);

    final updatedNewFontFile = newFontFile.copyWith(
      variants: [...newFontFile.variants, variantToMove],
    );

    await _updateStateWithFont(updatedNewFontFile);

    registerFont(updatedOriginFontFile, ref.read(talkerProvider));
    registerFont(updatedNewFontFile, ref.read(talkerProvider));

    final idToUpdate = await _getVariantIdFromDatabase(fontName, variantToMove);

    await _updateFontFamilyOfVariantInDatabase(idToUpdate, newFontName);
  }

  Future<void> updateFontVariant(
    String fontName,
    TiefPromptFontsVariant variant,
    int newWeight,
    FontStyle newStyle,
  ) async {
    final originFontFile = _getFontByName(fontName);
    final variantToUpdate = _getVariantFromFont(originFontFile, variant);
    final idToUpdate = await _getVariantIdFromDatabase(
      fontName,
      variantToUpdate,
    );

    final updatedVariant = variantToUpdate.copyWith(
      weight: newWeight,
      fontStyle: newStyle,
    );

    await _updateFontVariantInDatabase(idToUpdate, updatedVariant);
    await _updateStateWithFont(
      originFontFile.copyWith(
        variants: originFontFile.variants
            .map((v) => v == variantToUpdate ? updatedVariant : v)
            .toList(),
      ),
    );
  }

  Future<List<TiefPromptFontsFile>> _getFontFilesFromDatabase() async {
    final allFontNames =
        (await ref
                .read(databaseManagersProvider)
                .customFontModel
                .asyncMap((variant) => variant.familyName)
                .get())
            .toSet();

    final fontFiles = <TiefPromptFontsFile>[];

    for (final fontName in allFontNames) {
      final variants = await ref
          .read(databaseManagersProvider)
          .customFontModel
          .filter((f) => f.familyName.equals(fontName))
          .get();

      final fontFile = await CustomFontModelHelpers.variantsToFontsFile(
        fontName,
        variants,
      );

      fontFiles.add(fontFile);
    }

    return fontFiles;
  }

  Future<void> _ensureSelectedFontExists(
    List<TiefPromptFontsFile> allFonts,
  ) async {
    final settings = ref.read(settingsProvider).requireValue;
    final currentFontName = settings.config.fontFamily;

    final fontExists = allFonts.any((font) => font.name == currentFontName);

    if (!fontExists) {
      final fallbackFontName = allFonts.first.name;
      ref
          .read(talkerProvider)
          .warning(
            "Selected font family $currentFontName not found. Resetting to $fallbackFontName.",
          );
      ref.read(settingsProvider.notifier).setFontFamily(fallbackFontName);
    }
  }

  TiefPromptFontsFile _getMergedFont(TiefPromptFontsFile font) {
    final existingFont = state.requireValue
        // NOTE: Never merge with a built-in font
        .where((f) => !f.isBuiltIn)
        .where((f) => f.name == font.name)
        .singleOrNull;

    if (existingFont == null) {
      return font;
    }

    final variantExists = existingFont.variants
        .where((variant) => font.variants.any(_variantFilter(variant)))
        .isNotEmpty;

    if (variantExists) {
      throw Exception(
        'Font variant with the same weight already exists for font ${font.name}',
      );
    }

    return font.copyWith(
      variants: [...existingFont.variants, ...font.variants],
    );
  }

  bool _fontNameExists(String name) {
    return state.requireValue.any((font) => font.name == name);
  }

  Future<void> _saveFontToDatabase(TiefPromptFontsFile font) async {
    final databaseManager = ref.read(databaseManagersProvider);
    final existingVariantsForFont = await databaseManager.customFontModel
        .filter((f) => f.familyName.equals(font.name))
        .get();

    for (final variant in font.variants) {
      final variantInDatabase = existingVariantsForFont
          .where(_dbVariantFilter(variant))
          .singleOrNull;

      if (variantInDatabase == null) {
        await _insertFontVariantToDatabase(font.name, variant);
      } else {
        final idToUpdate = variantInDatabase.id;
        await _updateFontVariantInDatabase(idToUpdate, variant);
      }
    }
  }

  Future<void> _removeFontFamilyFromDatabase(TiefPromptFontsFile font) async {
    final databaseManager = ref.read(databaseManagersProvider);

    await databaseManager.customFontModel
        .filter((f) => f.familyName.equals(font.name))
        .delete();
  }

  bool Function(CustomFontModelData dbVariant) _dbVariantFilter(
    TiefPromptFontsVariant variant,
  ) {
    return (CustomFontModelData dbVariant) =>
        dbVariant.weight == variant.weight &&
        dbVariant.isItalic == (variant.fontStyle == FontStyle.italic);
  }

  Future<void> _insertFontVariantToDatabase(
    String fontName,
    TiefPromptFontsVariant variant,
  ) async {
    final databaseManager = ref.read(databaseManagersProvider);

    final fontData = await variant.load();

    await databaseManager.customFontModel.create(
      (o) => o(
        familyName: fontName,
        originalFileName: variant.originalFileName ?? 'unknown',
        weight: variant.weight,
        isItalic: Value(variant.fontStyle == FontStyle.italic),
        isVariableWeight: Value(variant.isVariable),
        weightMin: Value(variant.weightRange?.$1),
        weightMax: Value(variant.weightRange?.$2),
        data: fontData.buffer.asUint8List(),
      ),
    );
  }

  Future<void> _updateFontVariantInDatabase(
    int idToUpdate,
    TiefPromptFontsVariant variant,
  ) async {
    final databaseManager = ref.read(databaseManagersProvider);

    final fontData = await variant.load();

    await databaseManager.customFontModel
        .filter((f) => f.id.equals(idToUpdate))
        .update(
          (o) => o(
            originalFileName: Value(variant.originalFileName ?? 'unknown'),
            weight: Value(variant.weight),
            isItalic: Value(variant.fontStyle == FontStyle.italic),
            isVariableWeight: Value(variant.isVariable),
            weightMin: Value(variant.weightRange?.$1),
            weightMax: Value(variant.weightRange?.$2),
            data: Value(fontData.buffer.asUint8List()),
          ),
        );
  }

  Future<void> _deleteFontVariantFromDatabase(
    int idToDelete,
    TiefPromptFontsVariant variant,
  ) async {
    final databaseManager = ref.read(databaseManagersProvider);

    await databaseManager.customFontModel
        .filter((f) => f.id.equals(idToDelete))
        .delete();
  }

  Future<void> _updateFontFamilyOfVariantInDatabase(
    int idToUpdate,
    String newFontName,
  ) async {
    final databaseManager = ref.read(databaseManagersProvider);

    await databaseManager.customFontModel
        .filter((f) => f.id.equals(idToUpdate))
        .update((o) => o(familyName: Value(newFontName)));
  }

  Future<void> _updateStateWithFont(TiefPromptFontsFile font) async {
    final currentFonts = state.requireValue;
    final updatedFonts = [
      ...currentFonts.where((f) => f.name != font.name),
      font,
    ];
    state = AsyncValue.data(updatedFonts);
  }

  Future<void> _removeEmptyFontIfNoVariantsLeft(
    TiefPromptFontsFile font,
  ) async {
    state.whenData((fonts) {
      if (fonts
              .where((f) => f.name == font.name)
              .singleOrNull
              ?.variants
              .isEmpty ??
          false) {
        final updatedFonts = fonts.where((f) => f.name != font.name).toList();
        state = AsyncValue.data(updatedFonts);
      }
    });
  }

  TiefPromptFontsFile _getFontByName(String fontName) {
    final fontFile = state.requireValue
        .where((font) => font.name == fontName)
        .singleOrNull;

    if (fontFile == null) {
      throw Exception('Font with name $fontName not found');
    }

    return fontFile;
  }

  TiefPromptFontsVariant _getVariantFromFont(
    TiefPromptFontsFile font,
    TiefPromptFontsVariant variant,
  ) {
    final variantFile = font.variants
        .where(_variantFilter(variant))
        .singleOrNull;

    if (variantFile == null) {
      throw Exception('Variant not found in font ${font.name}');
    }

    return variantFile;
  }

  bool Function(TiefPromptFontsVariant variant) _variantFilter(
    TiefPromptFontsVariant variant,
  ) {
    return (TiefPromptFontsVariant existingVariant) =>
        existingVariant.weight == variant.weight &&
        existingVariant.fontStyle == variant.fontStyle;
  }

  bool Function(TiefPromptFontsVariant variant) _allOtherVariantsFilter(
    TiefPromptFontsVariant variant,
  ) {
    return (TiefPromptFontsVariant existingVariant) =>
        existingVariant.weight != variant.weight ||
        existingVariant.fontStyle != variant.fontStyle;
  }

  Future<int> _getVariantIdFromDatabase(
    String fontName,
    TiefPromptFontsVariant variant,
  ) async {
    final databaseManager = ref.read(databaseManagersProvider);

    final dbVariant = await databaseManager.customFontModel
        .filter((f) => f.familyName.equals(fontName))
        .filter((f) => f.weight.equals(variant.weight))
        .filter((f) => f.isItalic.equals(variant.fontStyle == FontStyle.italic))
        .getSingleOrNull();

    if (dbVariant == null) {
      throw Exception('Variant not found in database for font $fontName');
    }

    return dbVariant.id;
  }
}
