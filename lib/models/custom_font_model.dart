import 'package:drift/drift.dart';
import 'package:flutter/material.dart' hide Table;
import 'package:flutter/services.dart';
import 'package:tiefprompt/core/fonts.dart';
import 'package:tiefprompt/models/custom_font_model.drift.dart';

class CustomFontModel extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get originalFileName => text()();

  TextColumn get familyName => text()();
  // NOTE: Records default weight for variable fonts
  IntColumn get weight => integer()();
  BoolColumn get isItalic => boolean().withDefault(const Constant(false))();
  BoolColumn get isVariableWeight =>
      boolean().withDefault(const Constant(false))();
  // NOTE: For variable fonts, the min and max weight values
  //       Should only be set when isVariable is true
  IntColumn get weightMin => integer().nullable()();
  IntColumn get weightMax => integer().nullable()();
  BlobColumn get data => blob()();
}

class CustomFontModelHelpers {
  static TiefPromptFontsFile customFontModelToFontFile(
    CustomFontModelData font,
  ) => TiefPromptFontsFile(
    name: font.familyName,
    variants: [
      TiefPromptFontsVariant(
        weight: font.weight,
        fontStyle: font.isItalic ? FontStyle.italic : FontStyle.normal,
        originalFileName: font.originalFileName,
        isVariable: font.isVariableWeight,
        weightRange: font.isVariableWeight
            ? (font.weightMin!, font.weightMax!)
            : null,
        load: () => Future.value(ByteData.view(font.data.buffer)),
      ),
    ],
  );
}
