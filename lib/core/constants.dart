import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:tiefprompt/models/keybinding.dart';

const double kPrompterMinSpeed = 0.1;
const double kPrompterMaxSpeed = 20.0;

const double kPrompterMinFontSize = 12.0;
const double kPrompterMaxFontSize = 420.0;

const double kPrompterMinSideMargin = 0.0;
const double kPrompterMaxSideMargin = 99.0;

const String kRepoUrl = "https://github.com/Tiefseetauchner/tiefprompt";
const String kWeblateUrl = "https://hosted.weblate.org/projects/tiefprompt/";
const String kPrivacyPolicyUrl = "https://tiefprompt.com/policies/privacy/en/";
const String kLukeChriswalkerUrl = "https://www.lukechriswalker.at";

const String kNewScriptName = "New Script";

const Color kBrandTeal = Color(0xFF1FB6B6);
const Color kBrandAbyss = Color(0xFF0A1822);
const Color kBrandAbyssSurface = Color(0xFF10222E);
const Color kBrandAbyssSurfaceAlt = Color(0xFF0D1D27);
const Color kBrandBorderDark = Color(0xFF1D3543);
const Color kBrandDarkText = Color(0xFFD6E4E8);

const Color kBrandLightBackground = Color(0xFFF4F8F9);
const Color kBrandLightSurface = Color(0xFFFFFFFF);
const Color kBrandBorderLight = Color(0xFFD3E0E4);
const Color kBrandLightText = Color(0xFF0A1822);

const double kBrandRadius = 14.0;

const TalkerRiverpodLoggerSettings kTalkerRiverpodObserverSettings =
    TalkerRiverpodLoggerSettings(
      printMutationStart: false,
      printMutationSuccess: false,
      printProviderAdded: false,
      printProviderUpdated: false,
    );

const int kSettingsSchemaVersion = 1;

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
  ("Русский", Locale("ru")),
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
  markdown,
  settingsRestore,
  controlButtons,
  showHelpRequest,
  ephemeralScript,
  currentChapter,
}

enum FeatureKind { unverifiedBuild, freeVersion, paidVersion, fossVersion }

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
  Feature.markdown,
  Feature.settingsRestore,
  Feature.controlButtons,
  Feature.showHelpRequest,
  Feature.ephemeralScript,
  Feature.currentChapter,
];

const kFreeFeatures = [
  Feature.appLanguage,
  Feature.appTheme,
  Feature.primaryAppColor,
  Feature.textSettings,
  Feature.displaySettings,
  Feature.scrollSpeed,
  Feature.flipX,
  Feature.flipY,
  Feature.sideMargins,
  Feature.countdownTimer,
  Feature.fontSize,
  Feature.fontFamily,
  Feature.textAlignment,
  Feature.playPause,
  Feature.controlButtons,
  Feature.showHelpRequest,
  Feature.ephemeralScript,
];

const kProId = "io.github.tiefseetauchner.tiefprompt.pro";

final KeybindingMap kDefaultKeybindings = KeybindingMap([
  (KeybindingAction.playPause, Keybinding(LogicalKeyboardKey.enter.keyId)),
  (KeybindingAction.playPause, Keybinding(LogicalKeyboardKey.space.keyId)),

  (
    KeybindingAction.scrollUpSmall,
    Keybinding(LogicalKeyboardKey.arrowUp.keyId, shift: true),
  ),

  (
    KeybindingAction.scrollDownSmall,
    Keybinding(LogicalKeyboardKey.arrowDown.keyId, shift: true),
  ),
  (KeybindingAction.scrollUp, Keybinding(LogicalKeyboardKey.arrowUp.keyId)),
  (KeybindingAction.scrollDown, Keybinding(LogicalKeyboardKey.arrowDown.keyId)),
  (KeybindingAction.pageUp, Keybinding(LogicalKeyboardKey.pageUp.keyId)),
  (KeybindingAction.pageDown, Keybinding(LogicalKeyboardKey.pageDown.keyId)),
  (KeybindingAction.jumpStart, Keybinding(LogicalKeyboardKey.home.keyId)),
  (KeybindingAction.jumpEnd, Keybinding(LogicalKeyboardKey.end.keyId)),
  (KeybindingAction.toggleControls, Keybinding(LogicalKeyboardKey.tab.keyId)),
  (KeybindingAction.speedUp, Keybinding(LogicalKeyboardKey.equal.keyId)),
  (KeybindingAction.speedUp, Keybinding(LogicalKeyboardKey.numpadAdd.keyId)),
  (KeybindingAction.speedDown, Keybinding(LogicalKeyboardKey.minus.keyId)),
  (
    KeybindingAction.speedDown,
    Keybinding(LogicalKeyboardKey.numpadSubtract.keyId),
  ),
  (
    KeybindingAction.fontSizeUp,
    Keybinding(LogicalKeyboardKey.equal.keyId, ctrl: true),
  ),
  (
    KeybindingAction.fontSizeUp,
    Keybinding(LogicalKeyboardKey.numpadAdd.keyId, ctrl: true),
  ),
  (
    KeybindingAction.fontSizeDown,
    Keybinding(LogicalKeyboardKey.minus.keyId, ctrl: true),
  ),
  (
    KeybindingAction.fontSizeDown,
    Keybinding(LogicalKeyboardKey.numpadSubtract.keyId, ctrl: true),
  ),
  (
    KeybindingAction.openSettings,
    Keybinding(LogicalKeyboardKey.comma.keyId, ctrl: true),
  ),
  (
    KeybindingAction.saveSettingsFromPrompter,
    // NOTE: 115 is the KeyId for 's'.
    Keybinding(115, ctrl: true),
  ),
]);
