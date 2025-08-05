import 'dart:ui';

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
};

const kAllFeatures = [
  Feature.appLanguage,
  Feature.appTheme,
  Feature.primaryAppColor,
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
];

const kFreeFeatures = [
  Feature.appLanguage,
  Feature.appTheme,
  Feature.scrollSpeed,
  Feature.flipX,
  Feature.flipY,
  Feature.readingIndicatorBoxes,
  Feature.sideMargins,
  Feature.fontSize,
  Feature.textAlignment,
];

const kProId = "io.github.tiefseetauchner.tiefprompt.pro";
