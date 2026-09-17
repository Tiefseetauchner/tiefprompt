import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiefprompt/core/fonts.dart';
import 'package:tiefprompt/providers/fonts_provider.dart';
import 'package:tiefprompt/ui/screens/settings/font_settings_screen.dart';
import 'package:tief_screen/tief_screen.dart';
import 'package:tief_test_harness/tief_test_harness.dart';

import '../../constants.dart';
import '../harness_preparation.dart';

enum FontVariantKind { regular, bold, italic, boldItalic }

class _VariantSpec {
  final int weight;
  final FontStyle style;
  final String assetSuffix;

  const _VariantSpec(this.weight, this.style, this.assetSuffix);
}

const _kVariantSpecs = {
  FontVariantKind.regular: _VariantSpec(400, FontStyle.normal, "Regular"),
  FontVariantKind.bold: _VariantSpec(700, FontStyle.normal, "Bold"),
  FontVariantKind.italic: _VariantSpec(400, FontStyle.italic, "Italic"),
  FontVariantKind.boldItalic: _VariantSpec(700, FontStyle.italic, "BoldItalic"),
};

class SeededVariant {
  final Finder row;

  const SeededVariant(this.row);

  Finder get editIcon =>
      find.descendant(of: row, matching: find.byIcon(Icons.edit)).first;

  Finder get moveIcon =>
      find.descendant(of: row, matching: find.byIcon(Icons.move_down)).first;

  Finder get deleteIcon =>
      find.descendant(of: row, matching: find.byIcon(Icons.delete)).first;
}

class SeededFont {
  final String familyName;
  final Map<FontVariantKind, TiefPromptFontsVariant> _variants;

  const SeededFont(this.familyName, this._variants);

  Finder get tile => find.widgetWithText(ExpansionTile, familyName);

  Finder get editIcon =>
      find.descendant(of: tile, matching: find.byIcon(Icons.edit)).first;

  SeededVariant variant(FontVariantKind kind) {
    final variant = _variants[kind]!;
    final row = find.descendant(
      of: tile,
      matching: find.widgetWithText(
        ListTile,
        "Weight ${variant.weight}; Style ${variant.fontStyle.name}",
      ),
    );

    return SeededVariant(row);
  }
}

class FontSeeder {
  final WidgetTester tester;
  final String familyName;
  final String assetFamily;
  final List<FontVariantKind> _kinds = [];

  FontSeeder(this.tester, this.familyName, {this.assetFamily = "Roboto"});

  FontSeeder variant(FontVariantKind kind) {
    _kinds.add(kind);
    return this;
  }

  Future<SeededFont> seed() async {
    final container = ProviderScope.containerOf(
      tester.element(find.byType(FontSettingsScreen)),
    );
    final notifier = container.read(fontsProvider.notifier);

    final variants = {for (final kind in _kinds) kind: _buildVariant(kind)};

    await notifier.addFont(
      TiefPromptFontsFile(name: familyName, variants: variants.values.toList()),
    );

    await tester.pumpAndSettle();

    return SeededFont(familyName, variants);
  }

  TiefPromptFontsVariant _buildVariant(FontVariantKind kind) {
    final spec = _kVariantSpecs[kind]!;

    return TiefPromptFontsVariant(
      weight: spec.weight,
      fontStyle: spec.style,
      load: () async => await rootBundle.load(
        "assets/fonts/$assetFamily-${spec.assetSuffix}.ttf",
      ),
      originalFileName: "$assetFamily-${spec.assetSuffix}.ttf",
    );
  }
}

@RegisterHarness('Marketing Tablet', name: "Font Settings Screen")
Future<ScenarioHarness> buildFontSettingsHarness() async {
  final harness = prepareScreenshotHarness(
    appContent: const FontSettingsScreen(),
  );

  harness.addScenario(Scenario(name: "Foss"));

  harness.addScenario(
    Scenario(
      name: "Rename Highlight",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(font.editIcon, padding: 8);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Rename Dialog",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await tester.tap(font.editIcon);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Family Highlight",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await FontSeeder(
          tester,
          "Display Mono",
          assetFamily: "RobotoMono",
        ).variant(FontVariantKind.regular).seed();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(font.tile);
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Move Highlight",
      testCallback: (tester, binding) async {
        final source = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await FontSeeder(
          tester,
          "Display Mono",
          assetFamily: "RobotoMono",
        ).variant(FontVariantKind.regular).seed();

        await tester.tap(source.tile);
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          source.variant(FontVariantKind.regular).moveIcon,
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Move Dialog",
      testCallback: (tester, binding) async {
        final source = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await FontSeeder(
          tester,
          "Display Mono",
          assetFamily: "RobotoMono",
        ).variant(FontVariantKind.regular).seed();

        await tester.tap(source.tile);
        await tester.pumpAndSettle();

        await tester.tap(source.variant(FontVariantKind.regular).moveIcon);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Remove Variant Highlight",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(tester, "Cinematic Sans")
            .variant(FontVariantKind.regular)
            .variant(FontVariantKind.bold)
            .variant(FontVariantKind.italic)
            .variant(FontVariantKind.boldItalic)
            .seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          font.variant(FontVariantKind.italic).deleteIcon,
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Remove Variant Complete",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(tester, "Cinematic Sans")
            .variant(FontVariantKind.regular)
            .variant(FontVariantKind.bold)
            .variant(FontVariantKind.italic)
            .variant(FontVariantKind.boldItalic)
            .seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await tester.tap(font.variant(FontVariantKind.italic).deleteIcon);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Remove Last Variant Highlight",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          font.variant(FontVariantKind.regular).deleteIcon,
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Remove Last Variant Complete",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(
          tester,
          "Cinematic Sans",
        ).variant(FontVariantKind.regular).seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await tester.tap(font.variant(FontVariantKind.regular).deleteIcon);
        await tester.pumpAndSettle();
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Edit Variant Highlight",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(tester, "Cinematic Sans")
            .variant(FontVariantKind.regular)
            .variant(FontVariantKind.bold)
            .variant(FontVariantKind.italic)
            .variant(FontVariantKind.boldItalic)
            .seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await WidgetHighlighter(
          tester,
          defaultHighlightColor: kMarketingHighlightColor,
        ).highlightWidget(
          font.variant(FontVariantKind.bold).editIcon,
          padding: 8,
        );
      },
    ),
  );

  harness.addScenario(
    Scenario(
      name: "Edit Variant Dialog",
      testCallback: (tester, binding) async {
        final font = await FontSeeder(tester, "Cinematic Sans")
            .variant(FontVariantKind.regular)
            .variant(FontVariantKind.bold)
            .variant(FontVariantKind.italic)
            .variant(FontVariantKind.boldItalic)
            .seed();

        await tester.tap(font.tile);
        await tester.pumpAndSettle();

        await tester.tap(font.variant(FontVariantKind.bold).editIcon);
        await tester.pumpAndSettle();
      },
    ),
  );

  return harness;
}
