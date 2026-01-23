import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:tiefprompt/models/keybinding.dart';

const double kPrompterMinSpeed = 0.1;
const double kPrompterMaxSpeed = 20.0;

const double kPrompterMinFontSize = 12.0;
const double kPrompterMaxFontSize = 420.0;

const double kPrompterMinSideMargin = 0.0;
const double kPrompterMaxSideMargin = 99.0;

const List<String> kAvailableFonts = [
  'Roboto',
  'RobotoMono',
  'RobotoSlab',
  'OpenDyslexic',
];

const kSupportedLocales = [
  ("English", Locale("en", "US")),
  ("简体中文", Locale("zh", "CN")),
  ("Deutsch", Locale("de", "DE")),
  ("Pirate English", ExtendedLocale("en", "pirate")),
];

class ExtendedLocale extends Locale {
  const ExtendedLocale(super.languageCode, [super.countryCode]);

  @override
  String toString() {
    return super.toString().split("_").join("@");
  }
}

enum Feature {
  appLanguage,
  appTheme,
  primaryAppColor,
  textSettings,
  displaySettings,
  scrollSpeed,
  flipX,
  flipY,
  readingIndicatorBoxes,
  verticalMargins,
  verticalMarginFade,
  sideMargins,
  countdownTimer,
  prompterBackgroundColor,
  prompterTextColor,
  fontSize,
  textAlignment,
  fontFamily,
  keybindings,
  playPause,
}

enum FeatureKind { unverifiedBuild, freeVersion, paidVersion, fossVersion }

const kFeatureDescriptions = {
  Feature.appLanguage: "app_language_description",
  Feature.appTheme: "app_theme_description",
  Feature.primaryAppColor: "primary_app_color_description",
  Feature.scrollSpeed: "scroll_speed_description",
  Feature.flipX: "flip_x_description",
  Feature.flipY: "flip_y_description",
  Feature.readingIndicatorBoxes: "reading_indicator_boxes_description",
  Feature.verticalMargins: "vertical_margins_description",
  Feature.verticalMarginFade: "vertical_margin_fade_description",
  Feature.sideMargins: "side_margins_description",
  Feature.countdownTimer: "countdown_timer_description",
  Feature.prompterBackgroundColor: "prompter_background_color_description",
  Feature.prompterTextColor: "prompter_text_color_description",
  Feature.fontSize: "font_size_description",
  Feature.textAlignment: "text_alignment_description",
  Feature.fontFamily: "font_family_description",
  Feature.keybindings: "keybindings_description",
};

const kAllFeatures = [
  Feature.appLanguage,
  Feature.appTheme,
  Feature.primaryAppColor,
  Feature.textSettings,
  Feature.displaySettings,
  Feature.scrollSpeed,
  Feature.flipX,
  Feature.flipY,
  Feature.readingIndicatorBoxes,
  Feature.verticalMargins,
  Feature.verticalMarginFade,
  Feature.sideMargins,
  Feature.countdownTimer,
  Feature.prompterBackgroundColor,
  Feature.prompterTextColor,
  Feature.fontSize,
  Feature.textAlignment,
  Feature.fontFamily,
  Feature.keybindings,
  Feature.playPause,
];

const kFreeFeatures = [
  Feature.appLanguage,
  Feature.appTheme,
  Feature.textSettings,
  Feature.displaySettings,
  Feature.scrollSpeed,
  Feature.flipX,
  Feature.flipY,
  Feature.readingIndicatorBoxes,
  Feature.sideMargins,
  Feature.fontSize,
  Feature.textAlignment,
  Feature.playPause,
];

const kProId = "io.github.tiefseetauchner.tiefprompt.pro";

final KeybindingMap kDefaultKeybindings = KeybindingMap({
  KeybindingAction.playPause: [
    Keybinding(LogicalKeyboardKey.enter.keyId),
    Keybinding(LogicalKeyboardKey.space.keyId),
  ],
  KeybindingAction.scrollUpSmall: [
    Keybinding(LogicalKeyboardKey.arrowUp.keyId, shift: true),
  ],
  KeybindingAction.scrollDownSmall: [
    Keybinding(LogicalKeyboardKey.arrowDown.keyId, shift: true),
  ],
  KeybindingAction.scrollUp: [Keybinding(LogicalKeyboardKey.arrowUp.keyId)],
  KeybindingAction.scrollDown: [Keybinding(LogicalKeyboardKey.arrowDown.keyId)],
  KeybindingAction.pageUp: [Keybinding(LogicalKeyboardKey.pageUp.keyId)],
  KeybindingAction.pageDown: [Keybinding(LogicalKeyboardKey.pageDown.keyId)],
  KeybindingAction.jumpStart: [Keybinding(LogicalKeyboardKey.home.keyId)],
  KeybindingAction.jumpEnd: [Keybinding(LogicalKeyboardKey.end.keyId)],
  KeybindingAction.toggleControls: [Keybinding(LogicalKeyboardKey.tab.keyId)],
  KeybindingAction.speedUp: [
    Keybinding(LogicalKeyboardKey.equal.keyId),
    Keybinding(LogicalKeyboardKey.numpadAdd.keyId),
  ],
  KeybindingAction.speedDown: [
    Keybinding(LogicalKeyboardKey.minus.keyId),
    Keybinding(LogicalKeyboardKey.numpadSubtract.keyId),
  ],
  KeybindingAction.fontSizeUp: [
    Keybinding(LogicalKeyboardKey.equal.keyId, ctrl: true),
    Keybinding(LogicalKeyboardKey.numpadAdd.keyId, ctrl: true),
  ],
  KeybindingAction.fontSizeDown: [
    Keybinding(LogicalKeyboardKey.minus.keyId, ctrl: true),
    Keybinding(LogicalKeyboardKey.numpadSubtract.keyId, ctrl: true),
  ],
  KeybindingAction.openSettings: [
    Keybinding(LogicalKeyboardKey.comma.keyId, ctrl: true),
  ],
  KeybindingAction.saveSettingsFromPrompter: [
    // NOTE: 115 is the KeyId for 's'.
    Keybinding(115, ctrl: true),
  ],
});
