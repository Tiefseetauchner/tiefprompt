# Keybindings Architecture Task List

## Goals
- Replace hardcoded key handling in the prompter screen with a provider-backed, user-customizable keybinding system.
- Persist keybindings alongside existing settings and honor feature gating.
- Provide a settings UI for editing bindings with validation and conflict handling.

## Tasks

### 1) Model + Defaults
- Add `lib/models/keybinding.dart` with:
  - `enum KeybindingAction` covering current actions (play/pause, scroll, page, jump, toggle controls, speed, font size, open settings, save settings).
  - `class Keybinding` with `keyId`, `ctrl`, `shift`, `alt`, `meta` fields.
  - Serialization helpers (to/from JSON), and a `matches(KeyEvent)` method.
- Define default bindings that mirror current behavior in `lib/ui/screens/prompter_screen.dart`.

### 2) Provider + Persistence
- Add `lib/providers/keybindings_provider.dart` using Riverpod (async build like settings).
- Persist keybindings in `SharedPreferences` as JSON (action -> list of bindings).
- Expose methods:
  - `KeybindingAction? actionForEvent(KeyEvent event)`
  - `Future<void> setBindings(KeybindingAction action, List<Keybinding> bindings)`
  - `Future<void> resetToDefaults()`
  - `List<KeybindingConflict> validateConflicts()` (or similar)
- Add a small conflict strategy (reject new binding OR unbind conflicting action).

### 3) Feature Gating
- Add `Feature.keybindings` to `lib/core/constants.dart`.
- Add `keybindings_description` to `kFeatureDescriptions` and translations.
- Decide whether keybindings are free or paid; update `kAllFeatures`/`kFreeFeatures` accordingly.

### 4) Prompter Integration
- Update `lib/ui/screens/prompter_screen.dart`:
  - Replace direct key switches with a single lookup to `keybindingsProvider`.
  - Map `KeybindingAction` to existing prompter behaviors and scroll controller actions.
  - Preserve current modifier behavior (Ctrl + +/- for font size, etc.).

### 5) Settings UI
- Add a new settings entry (e.g., "Keybindings") in `lib/ui/screens/settings_screen.dart`.
- Create a screen or dialog to edit bindings:
  - Show all actions and their current bindings.
  - Tap action -> capture a key press to set binding.
  - Allow multiple bindings per action (optional), and removal.
  - Display conflict warnings inline.

### 6) Localization
- Add translation keys for:
  - "Keybindings" screen title
  - Action display names
  - Conflict messaging and reset prompt
- Update all locales in `assets/translations/`.

### 7) Tests (Optional but recommended)
- Unit tests for:
  - JSON serialization/deserialization
  - `matches(KeyEvent)` and modifier handling
  - Conflict detection
  - `actionForEvent` lookup behavior

### 8) Documentation
- Update README or in-app help text to mention customizable keybindings.
- Document defaults and conflict behavior.

