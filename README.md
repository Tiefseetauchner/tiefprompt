# TiefPrompt

[![](https://dcbadge.limes.pink/api/server/https://discord.gg/EG3zU9cTFx)](https://discord.gg/EG3zU9cTFx)
[![Weblate project translated](https://img.shields.io/weblate/progress/tiefprompt?style=for-the-badge)](https://hosted.weblate.org/projects/tiefprompt)

An extraordinarily simple cross-platform teleprompter.

## Usage

Load a script from a file or paste it into the input box.

Press play to start the teleprompter. Press pause to stop it. Press + to make it faster, - to make it slower. There's also a button to flip it vertically and one to flip it horizontally. Font size can also be adjusted.

## Download

[<img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
     alt="Get it on F-Droid"
     height="80">](https://f-droid.org/packages/io.github.tiefseetauchner.tiefprompt/)

Or download the latest APK from the [Releases Section](https://github.com/Tiefseetauchner/tiefprompt/releases/latest).

## Build

The `tools/build.sh` script is the easiest way to build the application.

```bash
Build TiefPrompt packages.
usage: build.sh [options]

-t target   Comma seperated list of targets to build. Options:
            linux,windows,androidaab,androidapk,macos,iosapp,iosipa
            (i) Can be set via environment variable 'TARGETS'
            (!) Required
-f freedom  Freedom level to apply to Application. Options:
            freemium,foss
            (i) Can be set via environment variable 'FREEDOM'
            (!) Required
-b dir      Build directory to place packages in.
            Default: /package
            (i) Unix path - not interpreted relatively!
            (i) Can be set via environment variable 'BUILD_DIR'
-s          Skip Flutter preperation.
-d          Run debug build.
-c          Continue on fail.
-q          Make script quiet.
-v          Make script verbose.
-V          Make script extremely verbose (careful here!).
-h          Show this help.
```

For example, to build linux and android APKs, run `./tools/build.sh -t linux,androidapk -f foss`.

Foss vs Freemium decides, which entrypoint is used. See the [Fossium](#fossium) section.

You can still run the app using `.flutter/bin/flutter run`, which will launch the fallback main.dart.

Note that, if you're building for windows, you will need a bash. I recommend the git bash, normally located under `C:\Program Files\Git\bin\bash.exe` to run `build.sh`.

## Fossium

This application is sadly not only an extreme time-, but also money sink for me. That's why I decided to make the application freemium when downloaded from the Apple App Store or Google Play.

This does not, however, affect F-Droid or my uploaded builds - these remain free as in beer. That's why I split the application in a `main_foss.dart` and a `main_freemium.dart` entrypoint. The different versions can be built using the build script, or just with `.flutter/bin/flutter build [target] -t main_[freedom].dart`.

However, if you want the foss version of the application to sideload on your iPhone, you will have to build it yourself. I'm sorry.

## Translations

We use hosted weblate (at this time at least) to translate the application.
Feel free to help out! [Join the project](https://hosted.weblate.org/projects/tiefprompt)!

When adding a new language, don't forget to add it to the lib/core/constants.dart kSupportedLocales
list.

## License

MIT. Look at [LICENSE](LICENSE) for details.

## Contributing

Be nice please?

## Coffee

I need more coffee. Please.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/tiefseetauchner)
