from compose import Canvas, Output, Placed, Position
from specs.positions import POS_TOP_LEFT
from specs.presets import desktop_window

HOME_CAROUSEL_COLLAGES: list[Output] = [
    Output("Home.webp", desktop_window("home_screen_wide/foss.png")),
    Output("Prompter.webp", desktop_window("prompter_screen/configured_script_no_chrome.png")),
    Output("Personalize.webp", desktop_window("prompter_screen/configured_script_format_overlay.png")),
]

FEATURE_SHOWCASE_COLLAGES: list[Output] = [
    Output(
        "Fonts.webp",
        Canvas(
            [
                Placed(desktop_window("prompter_screen/robotoslab_font.png"), POS_TOP_LEFT),
                Placed(desktop_window("prompter_screen/roboto_font.png"), Position(400, 100)),
                Placed(desktop_window("prompter_screen/open_dyslexic_font.png"), Position(800, 200)),
            ]
        ),
    ),
    Output("MirrorModes.webp", desktop_window("prompter_screen/mirrored_no_chrome.png")),
    Output("ReadingIndicators.webp", desktop_window("prompter_screen/reading_indicators_no_chrome.png")),
    Output("Margins.webp", desktop_window("prompter_screen/margins_no_chrome.png")),
    Output("Theming.webp", desktop_window("prompter_screen/custom_colors_no_chrome.png")),
    Output(
        "SavedScripts.webp",
        Canvas(
            [
                Placed(desktop_window("select_script_screen_wide/foss.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen_wide/prefilled.png"), Position(800, 200)),
            ]
        ),
    ),
    Output("Markdown.webp", desktop_window("prompter_screen/markdown_no_chrome.png")),
    Output("CountdownTimer.webp", desktop_window("prompter_screen/countdown_timer_no_chrome.png")),
    Output("SettingsStorage.webp", desktop_window("settings_restore_screen_wide/saved_settings.png")),
    Output("Keybindings.webp", desktop_window("keybindings_settings_screen_wide/foss.png")),
    Output(
        "Typography.webp",
        Canvas(
            [
                Placed(desktop_window("prompter_screen/crazy_typography_roboto.png"), POS_TOP_LEFT),
                Placed(
                    desktop_window("prompter_screen/crazy_typography_open_dyslexic.png"), Position(400, 100)
                ),
                Placed(desktop_window("prompter_screen/crazy_typography_robotomono.png"), Position(800, 200)),
            ]
        ),
    ),
    Output("CurrentChapterHeading.webp", desktop_window("prompter_screen/markdown_and_chapter.png")),
    Output("VoiceActivation.webp", desktop_window("scroll_settings_screen_wide/preview_voice_activation_active.png")),
]
