"""Declarative list of composed marketing images.

Add a new composite by appending a CollageSpec below (or to a new
per-screen list) — no changes to compose_lib.py needed. Mirrors how
integration_test/marketing/ adds a new runScenario call per screenshot.
"""

from compose_lib import CollageSpec, Position, WindowSpec

POS_TOP_LEFT = Position(0, 0)
POS_TOP_CENTER = Position(700, 0)
POS_TOP_RIGHT = Position(1400, 0)
POS_MIDDLE_LEFT = Position(0, 1000)
POS_MIDDLE_CENTER = Position(700, 1000)
POS_MIDDLE_RIGHT = Position(1400, 1000)
POS_BOTTOM_LEFT = Position(0, 1380)
POS_BOTTOM_CENTER = Position(700, 1380)
POS_BOTTOM_RIGHT = Position(1400, 1380)

POS_HERO_BACK_LEFT = Position(0, 200)
POS_HERO_BACK_RIGHT = Position(1400, 200)
POS_HERO_MIDDLE_CENTER = Position(700, 500)
POS_HERO_FRONT_CENTER = Position(250, 1600)

HOME_SCREEN_COLLAGES: list[CollageSpec] = [
    CollageSpec(
        output="Hero.webp",
        windows=[
            WindowSpec(
                input="select_script_screen_light_foss.png",
                title="TiefPrompt",
                position=POS_HERO_BACK_LEFT,
            ),
            WindowSpec(
                input="home_screen_dark_foss_pink.png",
                title="TiefPrompt",
                position=POS_HERO_BACK_RIGHT,
            ),
            WindowSpec(
                input="home_screen_light_foss_prefilled.png",
                title="TiefPrompt",
                position=POS_HERO_MIDDLE_CENTER,
            ),
            WindowSpec(
                input="prompter_screen_light_foss_prefilled.png",
                title="TiefPrompt",
                position=POS_HERO_FRONT_CENTER,
            ),
        ],
    ),
    CollageSpec(
        output="ChangeLanguage.webp",
        windows=[
            WindowSpec(
                input="home_screen_light_foss_settings_highlighted.png",
                title="TiefPrompt",
                position=POS_TOP_LEFT,
            ),
            WindowSpec(
                input="main_settings_screen_light_default_language_highlighted.png",
                title="TiefPrompt",
                position=POS_TOP_RIGHT,
            ),
        ],
    ),
    CollageSpec(
        output="ChangeTheme.webp",
        windows=[
            WindowSpec(
                input="home_screen_light_foss_settings_highlighted.png",
                title="TiefPrompt",
                position=POS_TOP_LEFT,
            ),
            WindowSpec(
                input="main_settings_screen_light_theme_highlighted.png",
                title="TiefPrompt",
                position=POS_TOP_RIGHT,
            ),
            WindowSpec(
                input="home_screen_dark_foss.png",
                title="TiefPrompt",
                position=POS_MIDDLE_LEFT,
            ),
            WindowSpec(
                input="main_settings_screen_dark_theme_highlighted.png",
                title="TiefPrompt",
                position=POS_MIDDLE_RIGHT,
            ),
        ],
    )
]

ALL_COLLAGES: list[CollageSpec] = HOME_SCREEN_COLLAGES
