# Contribution guidelines

This project has more boilerplate than real code, and a couple of hacky, genuinely cursed corners.

A not quite short, opinionated list. Most of these exist because something broke once.
The checklists at the end are only important if you need them, if you don't want to
see the bodge, don't read them preemptively.

## 0. Setup

- Clone with submodules. Either `git clone --recursive <url>`, or if you already
  cloned: `git submodule update --init --recursive`. Half the project lives in
  submodules; without them nothing builds. Heads up: `.flutter` *is* the whole
  Flutter SDK (pinned via submodule, fetched over SSH), so the clone is big and
  slow and the first `.flutter/bin/flutter` run bootstraps its own Dart. This is
  normal, go get a coffee. Or use the OS toolchain if you must, but this is at
  the end of a long sentence on purpose, I don't like the idea of random versions
  breaking my CI build (been there done that).
- Always use the bundled toolchain: `.flutter/bin/flutter` and `.flutter/bin/dart`,
  never your system `flutter` / `dart`. The version is pinned for a reason, and
  mismatched versions cause exactly the kind of mischief you don't want to debug.
- Generate code before you build anything. The Freezed / Riverpod / Drift part
  files (`*.freezed.dart`, `*.g.dart`, `*.drift.dart`) are not checked in, so a
  fresh clone is full of "undefined `_$SettingsState`" errors until you run:

      .flutter/bin/dart run build_runner build --delete-conflicting-outputs

  (`build_runner watch` if you'd rather it keep up as you go). If you touch the
  Drift schema you also need `.flutter/bin/dart run drift_dev make-migrations`.

## 1. Build both flavors before opening a PR

TiefPrompt ships in two flavors that differ *only* by entrypoint:
`lib/main_foss.dart` (F-Droid, direct APK) and `lib/main_freemium.dart`
(App Store, Play Store). Freemium pulls in IAP packages; FOSS must build
without them.

It is entirely possible to write code that builds fine for freemium but breaks
FOSS, because something you imported imported something that imported an
IAP-only dependency. This has happened. So build *both* before you push:

    .flutter/bin/flutter build <target> -t lib/main_foss.dart
    .flutter/bin/flutter build <target> -t lib/main_freemium.dart

(or `tools/build.sh -t <targets> -f <freedom>`). A PR that only builds one
flavor is not done. (CI should catch it, but darn me if that ever not 
works...)

## 2. Separate concerns

The layers, and what belongs in each:

- `lib/core/`: reusable utilities and shared code
- `lib/models/`: the Drift database and its models
- `lib/providers/`: Riverpod providers that *own* state
- `lib/services/`: Riverpod providers that are stateless and purely functional
- `lib/ui/`: screens and widgets

Hard rules:

- DB access does not live in the UI. Route it through a provider or service.
- Don't reach across layers to dodge writing a provider. Write the provider.

(Yes, `feature_provider` lives in `providers/` but is really a service. It's a
known wart, left as-is on purpose, so don't "fix" it as a drive-by, there be
dragons.)

## 3. Think about what you've done

Before you open the PR, re-read your own diff. Not for typos, for fit. Does it
match how the surrounding code already does things, or did you invent a second
way? Did you add state to a widget that should have been a provider? Did you
hardcode something that has a constant three files over? Most review comments
on this repo are things the author would have caught by reading their own diff
once.

## 4. Don't branch on flavor in the UI

Widgets must never ask "am I FOSS or freemium?". Gating goes through the feature
system: wrap things in `_FeatureGate` / `_FeatureGatedIconButton`, or check
`featuresProvider.select((s) => s.features.contains(Feature.x))` (see
`prompter_bottom_bar.dart` and `app_settings.dart`). Note that `AppSetting` and
its derivatives gate themselves automatically off the `Feature` you give them,
so for those you just need to pass the right one. The only place flavor actually
differs is the entrypoint and its `feature_provider` override. Keep it that way,
it's the whole reason the split stays maintainable. (Ignore the BS I did early
day with the button on the home screen. If you dare, fix it.)

## 5. State lives in providers; navigate with go_router

- Prefer providers over widget-local state so it survives rebuilds. Use
  `@riverpod` codegen by default; a plain `Notifier` is fine only for trivial
  single-value toggles (see `controlsVisibleProvider`).
- All navigation goes through `go_router`. Don't call `Navigator.push` directly.
- Routes go in `router_provider.dart`. This may seem confusing, but it has
  reasons. Reasons I can't remember. But reasons!

## 6. Localize user-facing strings, but stay in your lane

Every string a user sees goes through `easy_localization`:
`context.tr("Some.Key")`, with the key defined in the translation assets.
Hardcoded strings are acceptable only where no `BuildContext` is available, and
those must be in English.

Only touch English and your own native language. Do not edit, "improve", or add
other languages, and do not commit AI-generated translations. A wrong
translation you can't read is worse than a missing one, leave those to people
who actually speak the language.

## 7. Profit

---

## When I add a Feature

A `Feature` is not "a Pro thing". It's the unit of gating for the whole app. The
point is to be able to move any capability between free and Pro trivially. So:
if you implement anything that does something and could *conceivably* be gated,
give it a `Feature`. When in doubt, add one.

Always add a *new* `Feature`. Never reuse an existing one because it's "close
enough" (e.g. don't gate a new line-height control behind `Feature.fontSize`).
Reuse looks cheaper today and welds two capabilities together forever, which
defeats the entire reason this enum exists. Yes, a new Feature costs you the
extra steps below. Pay them.

1. Add the value to the `Feature` enum in `core/constants.dart`.
2. Add it to `kAllFeatures`. Add it to `kFreeFeatures` too if it should be free
   in the freemium build.
3. Gate it in the UI with `_FeatureGate` / `_FeatureGatedIconButton`, or a
   `featuresProvider.select(...)` check. Never check the flavor directly. (If
   the thing is an `AppSetting` or a derivative, it gates itself off the
   `Feature` you pass it, so just pass the right one.)
4. Add a `BuyProScreen.BuyRequest.<featureName>` translation key. It's rendered
   as Markdown on the buy screen when someone taps the locked feature, so give
   it an h2 header and a little description of what they're buying.

## When I add a Route

1. Add a `GoRoute` in `router_provider.dart` (nest it under `/settings` if it's
   a settings subscreen).
2. Create the screen widget under `lib/ui/screens/` (or `screens/settings/`).
3. Navigate to it with `context.push("/your_path")`.
4. If it needs arguments, pass them via `extra:` using a small router-extra
   class (see `DisabledFeatureScreenRouterExtra`).
5. Re-run `build_runner` (you edited `router_provider.dart`).

## When I add a Setting

Settings persist to disk and fan out across a lot of spots. This is the worst
checklist in the file, because the fan-out is wide *and* nobody has ever gotten
all of it right in one pass (see the warning at the end). For one new setting,
in order:

1. A field on `SettingsState` with an `@Default`, in `settings_provider.dart`.
2. `SettingsState.fromJson` and `toJson` (used by settings export/restore).
3. A `_xKey` constant, and read it in `Settings.build()`.
4. The setter on the `ISettings` interface.
5. The setter implementation (write to prefs, then `state.whenData(copyWith)`).
6. `_saveSettings`.
7. The Drift preset path, which is *two* files, not one:
   - `settings_preset_model.dart`: add the column. A non-nullable column
     (`real()()`, `boolean()()`, ...) has no default, so existing preset rows
     have nothing for it. Run `.flutter/bin/dart run drift_dev make-migrations`,
     then open the generated migration and give it a sane default, or the
     migration fails on anyone's existing data.
   - `settings_storage_service.dart`: wire the field into **both** `_mapToState`
     (DB row -> `SettingsState`) and `save()` (`SettingsState` -> DB row).
     `save()` calls `create(...)` with every column as a required arg, so until
     you add it here, it won't even compile.
8. The UI control. It goes in a settings screen under
   `lib/ui/screens/settings/` (e.g. `text_settings_screen.dart`), usually as a
   `NumberAppSetting` / `BooleanAppSetting` / etc. Those widget classes live in
   `app_settings.dart`, which is the *kit*, not where instances go. The
   `AppSetting` widgets auto-gate off the `Feature` you pass them. Optionally
   also expose the setting in the prompter bottom-bar dialog if it makes sense
   live.
9. Localization keys, usually *more than one*. A `NumberAppSetting` wants a label
   key and a `_Unit` key (e.g. `NumberAppSetting_DefaultFontSize` plus
   `..._Unit`); the live prompter version may want more, some with args. Add
   them to `en-US.json` and your native language only (see section 6).
10. Re-run `build_runner` (you edited the Freezed `SettingsState` and the Drift
    table).

There are two independent schema versions and they bite differently:

- Drift's `schemaVersion` in `database.dart` is bumped by `make-migrations` and
  governs the on-device database (step 7).
- `kSettingsSchemaVersion` in `constants.dart` governs JSON export/restore.
  `settings_restore_screen.dart` rejects any imported file whose version is not
  an *exact* match. So if you add a `toJson` field you have a real choice to
  make: bump `kSettingsSchemaVersion` and old exports stop importing, or leave
  it and rely on the lenient `?? default` in `fromJson`. Neither is free; pick on
  purpose, don't bump it on reflex.

If the setting also shows up live in the prompter, see "When I add a Prompter
state" and wire it into `applySettingsFromPrompter`. If it's gateable (it is),
also do "When I add a Feature".

Important: settings state and prompter state are kept separate on purpose. The
prompter does NOT auto-save into settings; it only persists when the user hits
Save (`applySettingsFromPrompter`). That's so we 1. don't hammer the disk and 2. 
let people experiment in the prompter without wrecking their real settings.
Don't "helpfully" wire the prompter to auto-save. It's a feature, not a bug.

Warning: copy a *complete* setting as your template, and don't trust any single
one to be complete. The fan-out above is manual, so some existing settings are
only wired through part of it. I don't know whether any do that or which they 
are, but it's a dangerous place to be. When you add a setting, grep your new 
field name across the repo at the end and confirm it appears in every spot the 
checklist lists. If your "template" setting doesn't appear in one of them, 
that's a bug in the template, not permission to skip the step.

## When I add a Prompter state

(Prompter state is the live, in-session state of the teleprompter, separate from
saved settings. See the separation note above.)

1. A field on `PrompterState` with an `@Default`, in `prompter_provider.dart`.
   Note: a value's default may differ between existing settings. That's a bug.
   Not a feature. The canonical value may not be clear, so when you see one of 
   those, ask which one's the right one. Don't assume. Other than that, don't 
   make the same mistakes I made ;)
2. A mutator on `Prompter` (`setX` / `toggleX`). Numeric ones clamp against
   `kPrompter*` constants, but the pair you need may not exist yet. If not, add
   `kPrompterMin<X>` / `kPrompterMax<X>` to `constants.dart`. The same pair
   usually doubles as the min/max of the `NumberAppSetting` in the settings UI.
3. If it mirrors a saved setting, add it to `Prompter.applySettings` and do
   "When I add a Setting". Be aware this is a two-way hand-sync: `applySettings`
   (Settings -> Prompter) and `applySettingsFromPrompter` (Prompter -> Settings)
   both enumerate every mirrored field. A prompter-mirrored setting therefore 
   costs more edit sites than the Setting checklist totals up; budget for both 
   directions.
4. Wire the control into the prompter UI (`prompter_bottom_bar.dart` dialogs or
   the overlay), and read it wherever it actually affects rendering. E.g. text 
   styling like size and line height is built into the `TextStyle` in `prompter_screen.dart` 
   and passed down. Two gotchas: `scrollable_text.dart` derives scroll speed 
   from `fontSize`, so anything that changes effective line size can quietly change 
   scroll feel; and the Markdown path renders through `Markdown` from the 
   `tief_weave` submodule, so whether it honors a given `TextStyle` property is 
   a question you answer by reading code in that submodule, not this repo.
   Oh and feel free to improve `tief_weave`, it's a... bad repo.
5. Re-run `build_runner` (you edited the Freezed `PrompterState`).

---

(Yes the last two are recursive. No I will not apologize. If you're an AI stuck
with this, call your human for help if you have one.)
