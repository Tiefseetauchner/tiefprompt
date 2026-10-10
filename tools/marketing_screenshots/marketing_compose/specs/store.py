from compose import Output, in_folder
from specs.presets import android_screen

STORE_SCREENSHOTS: list[tuple[str, str, str]] = [
    ("home_screen_dark.png", "home", "home_screen_dark_prefilled"),
    ("home_screen_default.png", "home", "home_screen_light"),
    ("load_script.png", "select_script", "select_script"),
    ("settings_screen.png", "settings", "settings"),
    ("prompter_screen.png", "prompter", "prompter"),
    ("prompter_screen_color.png", "prompter", "custom_colors"),
]

STORE_LOCALES: dict[str, str] = {
    "en-US": "en-US",
    "en@pirate": "en-pirate",
    "de": "de-DE",
    "zh-CN": "zh-CN",
    "ru-RU": "ru",
    "ar": "ar",
}

STORE_DEVICES: dict[str, str] = {
    "phoneScreenshots": "phone",
    "sevenInchScreenshots": "seveninchtablet",
    "tenInchScreenshots": "teninchtablet",
}


def _store_screenshots(language: str, device: str) -> list[Output]:
    return [
        Output(output, android_screen(f"store_{folder}/{device}/{language.lower()}_{name}.png"))
        for output, folder, name in STORE_SCREENSHOTS
    ]


STORE_OUTPUTS: list[Output] = [
    output
    for device_folder, device in STORE_DEVICES.items()
    for locale_folder, language in STORE_LOCALES.items()
    for output in in_folder(
        f"metadata/{locale_folder}/images/{device_folder}",
        _store_screenshots(language, device),
    )
]
