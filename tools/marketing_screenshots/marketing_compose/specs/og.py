from compose import (
    Asset,
    Canvas,
    DropShadow,
    HorizontalGradient,
    Layer,
    Output,
    PillBackground,
    Placed,
    Position,
    ResizeToHeight,
    ResizeToWidth,
    Row,
    Screenshot,
    Text,
    Titlebar,
)

OG_SIZE = (1200, 630)
OG_MARGIN = 60

BACKGROUND_START = (12, 40, 50)
BACKGROUND_END = (17, 74, 81)
FOREGROUND = (214, 228, 231)
ACCENT = (30, 183, 181)


def _brand() -> Layer:
    return Row(
        [
            ResizeToHeight(Asset("assets/images/icon_bg_round_512x512.png"), 64),
            Text("TiefPrompt", 32, FOREGROUND, "Medium"),
        ],
        gap=18,
    )


def _headline(text: str) -> Layer:
    return Text(text, 56, FOREGROUND, "Bold", max_width=460, line_spacing=1.15)


def _website() -> Layer:
    return PillBackground(Text("tiefprompt.com", 24, BACKGROUND_START, "Medium"), ACCENT, padding=(26, 10))


WINDOW_POSITION = Position(520, 65)


def landscape_window(screenshot: str) -> Layer:
    return DropShadow(Titlebar(ResizeToHeight(Screenshot(screenshot), 376)))


def portrait_window(screenshot: str) -> Layer:
    return DropShadow(Titlebar(ResizeToWidth(Screenshot(screenshot), 460)))


def og_image(headline: str, window: Layer) -> Layer:
    _, height = OG_SIZE
    return Canvas(
        [
            Placed(HorizontalGradient(OG_SIZE, BACKGROUND_START, BACKGROUND_END), Position(0, 0)),
            Placed(_brand(), Position(OG_MARGIN, 93), anchor=(0, 0.5)),
            Placed(_headline(headline), Position(OG_MARGIN, height // 2), anchor=(0, 0.5)),
            Placed(_website(), Position(OG_MARGIN, height - OG_MARGIN), anchor=(0, 1)),
            Placed(window, WINDOW_POSITION),
        ],
        size=OG_SIZE,
    )


OG_IMAGES: list[Output] = [
    Output(
        "home.jpg",
        og_image("Free open source teleprompter", portrait_window("home_screen/prefilled.png")),
    ),
    Output(
        "changelog.jpg",
        og_image("Changelogs", landscape_window("home_screen_wide/prefilled.png")),
    ),
    Output(
        "countdown_timer.jpg",
        og_image(
            "Get Ready with the Countdown Timer",
            landscape_window("prompter_screen/countdown_timer_no_chrome.png"),
        ),
    ),
    Output(
        "font_choice.jpg",
        og_image("Choose your font and upload your own", portrait_window("font_settings_screen/foss.png")),
    ),
    Output(
        "keybindings.jpg",
        og_image(
            "Upgrade your usability with Keybinds",
            portrait_window("keybindings_settings_screen/light_theme.png"),
        ),
    ),
    Output(
        "margins.jpg",
        og_image("Focus on what's relevant", landscape_window("prompter_screen/margins_no_chrome.png")),
    ),
    Output(
        "markdown.jpg",
        og_image("Markdown in Every Script", landscape_window("prompter_screen/markdown_no_chrome.png")),
    ),
    Output(
        "current_chapter_headings.jpg",
        og_image("Always Know Your Chapter", landscape_window("prompter_screen/markdown_and_chapter.png")),
    ),
    Output(
        "mirror_modes.jpg",
        og_image(
            "Mirror to your Heart's Content", landscape_window("prompter_screen/mirrored_no_chrome.png")
        ),
    ),
    Output(
        "reading_indicators.jpg",
        og_image(
            "Reading Indicators",
            landscape_window("prompter_screen/reading_indicators_no_chrome.png"),
        ),
    ),
    Output(
        "saved_scripts.jpg",
        og_image("Save and Revisit Your Scripts", portrait_window("select_script_screen/foss.png")),
    ),
    Output(
        "settings_storage.jpg",
        og_image("Manage Your Storage", portrait_window("settings_restore_screen/saved_settings.png")),
    ),
    Output(
        "theming.jpg",
        og_image("Make it your Prompter", landscape_window("prompter_screen/custom_colors_no_chrome.png")),
    ),
    Output(
        "typography.jpg",
        og_image(
            "Crazy Good Typography",
            landscape_window("prompter_screen/crazy_typography_robotomono.png"),
        ),
    ),
    Output(
        "voice_activation.jpg",
        og_image(
            "Scrolling with Voice Activation",
            portrait_window("scroll_settings_screen/preview_voice_activation_active.png"),
        ),
    ),
]
