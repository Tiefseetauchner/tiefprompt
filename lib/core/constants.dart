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

const String kApplicationVersion = '0.8.0';

const kSupportedLocales = [
  ("English", Locale("en", "US")),
  ("简体中文", Locale("zh", "CN")),
  ("Deutsch", Locale("de", "DE")),
];
