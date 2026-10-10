"""Every image compose.sh renders. Add a new one by appending an Output to the matching list."""

from compose import Output, in_folder
from specs import docs, web
from specs.og import OG_IMAGES
from specs.store import STORE_OUTPUTS

ALL_OUTPUTS: list[Output] = (
    in_folder("docs/hero", docs.HERO_SCREEN_COLLAGES)
    + in_folder("web", web.HOME_CAROUSEL_COLLAGES)
    + in_folder("web/features", web.FEATURE_SHOWCASE_COLLAGES)
    + in_folder("web/og", OG_IMAGES)
    + in_folder("docs/home_screen", docs.HOME_SCREEN_COLLAGES)
    + in_folder("docs/main_settings_screen", docs.MAIN_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/settings_subscreens", docs.SETTINGS_SUBSCREENS_COLLAGES)
    + in_folder("docs/text_settings_screen", docs.TEXT_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/display_settings_screen", docs.DISPLAY_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/scroll_settings_screen", docs.SCROLL_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/keybindings_settings_screen", docs.KEYBINDINGS_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/saved_settings_screen", docs.SAVED_SETTINGS_SCREEN_COLLAGES)
    + in_folder("docs/select_script_screen", docs.SELECT_SCRIPT_SCREEN_COLLAGES)
    + in_folder("docs/prompter_screen", docs.PROMPTER_SCREEN_COLLAGES)
    + in_folder("docs/font_settings_screen", docs.CUSTOM_FONT_SETTINGS_SCREEN_COLLAGES)
    + STORE_OUTPUTS
)
