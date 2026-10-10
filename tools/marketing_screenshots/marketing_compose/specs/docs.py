from compose import Canvas, Output, Placed, Position
from specs.positions import (
    POS_BOTTOM_LEFT,
    POS_HERO_BACK_LEFT,
    POS_HERO_BACK_RIGHT,
    POS_HERO_FRONT_CENTER,
    POS_HERO_MIDDLE_CENTER,
    POS_TOP_CENTER,
    POS_TOP_LEFT,
    POS_TOP_RIGHT,
)
from specs.presets import desktop_window

HERO_SCREEN_COLLAGES: list[Output] = [
    Output(
        "Hero.webp",
        Canvas(
            [
                Placed(desktop_window("select_script_screen/foss.png"), POS_HERO_BACK_LEFT),
                Placed(desktop_window("home_screen/dark_pink_primary.png"), POS_HERO_BACK_RIGHT),
                Placed(desktop_window("home_screen/prefilled.png"), POS_HERO_MIDDLE_CENTER),
                Placed(desktop_window("prompter_screen/configured_script.png"), POS_HERO_FRONT_CENTER),
            ]
        ),
    ),
]

HOME_SCREEN_COLLAGES: list[Output] = [
    Output(
        "OpenSettings.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen_highlights/settings.png"), POS_TOP_LEFT),
                Placed(desktop_window("main_settings_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output("TitleBox.webp", desktop_window("home_screen_highlights/title_box.png")),
    Output("ScriptContentBox.webp", desktop_window("home_screen_highlights/content_box.png")),
    Output("PrimaryButtons.webp", desktop_window("home_screen_highlights/primary_buttons.png")),
    Output(
        "Variant.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen_highlights/variant_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen_highlights/variant_popup.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "VariantFoss.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen/foss.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen/foss_popup.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "VariantFree.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen/freemium_free.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen/freemium_free_popup.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "VariantPro.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen/freemium_pro.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen/freemium_pro_popup.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "StartButton.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen_highlights/start_button.png"), POS_TOP_LEFT),
                Placed(desktop_window("prompter_screen_narrow/defaults.png"), Position(350, 800)),
            ]
        ),
    ),
]

MAIN_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "ChangeLanguage.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/change_language.png"), POS_TOP_LEFT),
                Placed(desktop_window("main_settings_screen/german.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "ChangeTheme.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/change_theme.png"), POS_TOP_LEFT),
                Placed(desktop_window("main_settings_screen/dark_theme_open.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "KeybindingsSettings.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/keybindings_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("keybindings_settings_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "SaveAndRestoreSettings.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/save_and_restore_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "PrimaryColor.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/primary_color_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("main_settings_screen/primary_color_picker.png"), POS_TOP_CENTER),
                Placed(desktop_window("home_screen/teal_primary.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output("UseSystemColors.webp", desktop_window("main_settings_screen/use_system_colors_highlighted.png")),
]

SETTINGS_SUBSCREENS_COLLAGES: list[Output] = [
    Output(
        "DisplaySettingsScreen.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/display_settings_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("display_settings_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "SubSettingsScreens.webp",
        Canvas(
            [
                Placed(desktop_window("display_settings_screen/light_theme.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/light_theme.png"), POS_TOP_CENTER),
                Placed(desktop_window("scroll_settings_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
]

TEXT_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "TextSettingsScreen.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/text_settings_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/light_theme.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "DefaultFontSize.webp",
        Canvas(
            [
                Placed(desktop_window("text_settings_screen/default_font_size_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/default_font_size_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "TextAlignment.webp",
        Canvas(
            [
                Placed(desktop_window("text_settings_screen/text_alignment_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/text_alignment_open.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "FontFamily.webp",
        Canvas(
            [
                Placed(desktop_window("text_settings_screen/font_family_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/font_family_open.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "TextDirection.webp",
        Canvas(
            [
                Placed(desktop_window("text_settings_screen/text_direction_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("text_settings_screen/text_direction_open.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output("EnableMarkdown.webp", desktop_window("text_settings_screen/enable_markdown_highlight.png")),
    Output(
        "ShowCurrentChapter.webp", desktop_window("text_settings_screen/show_current_chapter_highlight.png")
    ),
]

CUSTOM_FONT_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "CustomFonts.webp",
        Canvas(
            [
                Placed(desktop_window("text_settings_screen/custom_fonts_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("font_settings_screen/foss.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "RenameFontFamily.webp",
        Canvas(
            [
                Placed(desktop_window("font_settings_screen/rename_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("font_settings_screen/rename_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "MoveFontVariant.webp",
        Canvas(
            [
                Placed(desktop_window("font_settings_screen/family_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("font_settings_screen/move_highlight.png"), POS_TOP_CENTER),
                Placed(desktop_window("font_settings_screen/move_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "RemoveFontVariantFamilyRemains.webp",
        Canvas(
            [
                Placed(desktop_window("font_settings_screen/remove_variant_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("font_settings_screen/remove_variant_complete.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "RemoveFontVariantFamilyRemoved.webp",
        Canvas(
            [
                Placed(
                    desktop_window("font_settings_screen/remove_last_variant_highlight.png"), POS_TOP_LEFT
                ),
                Placed(
                    desktop_window("font_settings_screen/remove_last_variant_complete.png"), POS_TOP_RIGHT
                ),
            ]
        ),
    ),
    Output(
        "EditFontVariant.webp",
        Canvas(
            [
                Placed(desktop_window("font_settings_screen/edit_variant_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("font_settings_screen/edit_variant_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
]

SAVED_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "SaveSettings.webp",
        Canvas(
            [
                Placed(desktop_window("settings_restore_screen/save_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/save_dialog.png"), POS_TOP_CENTER),
                Placed(desktop_window("settings_restore_screen/save_complete.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "ExportSettings.webp",
        Canvas(
            [
                Placed(desktop_window("settings_restore_screen/export_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/export_dialog_highlight.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "ImportSettings.webp",
        Canvas(
            [
                Placed(desktop_window("settings_restore_screen/import_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/import_dialog_highlight.png"), POS_TOP_CENTER),
                Placed(desktop_window("settings_restore_screen/import_complete.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "RestoreSuccess.webp",
        Canvas(
            [
                Placed(desktop_window("settings_restore_screen/restore_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/restore_success.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "DeleteSettings.webp",
        Canvas(
            [
                Placed(desktop_window("settings_restore_screen/delete_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/delete_dialog_highlight.png"), POS_TOP_CENTER),
                Placed(desktop_window("settings_restore_screen/delete_complete.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "SavedSettingsScreen.webp",
        Canvas(
            [
                Placed(desktop_window("main_settings_screen/save_and_restore_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("settings_restore_screen/saved_settings.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
]

KEYBINDINGS_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "PlayPause.webp",
        Canvas(
            [
                Placed(desktop_window("keybindings_settings_screen/play_pause_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("keybindings_settings_screen/play_pause_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "AddBinding.webp",
        Canvas(
            [
                Placed(desktop_window("keybindings_settings_screen/add_binding_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("keybindings_settings_screen/add_binding_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "RemoveBinding.webp",
        Canvas(
            [
                Placed(desktop_window("keybindings_settings_screen/custom_binding_dialog.png"), POS_TOP_LEFT),
                Placed(desktop_window("keybindings_settings_screen/play_pause_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
]

DISPLAY_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output("Flip.webp", desktop_window("display_settings_screen/flip_highlight.png")),
    Output(
        "ControlButtonsEnable.webp",
        desktop_window("display_settings_screen/control_buttons_enable_highlight.png"),
    ),
    Output(
        "ControlButtonsPosition.webp",
        Canvas(
            [
                Placed(
                    desktop_window("display_settings_screen/control_buttons_position_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("display_settings_screen/control_buttons_position_open.png"), POS_TOP_RIGHT
                ),
            ]
        ),
    ),
    Output(
        "ReadingIndicators.webp", desktop_window("display_settings_screen/reading_indicators_highlight.png")
    ),
    Output(
        "ReadingIndicatorsHeight.webp",
        Canvas(
            [
                Placed(
                    desktop_window("display_settings_screen/reading_indicators_height_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("display_settings_screen/reading_indicators_height_dialog.png"),
                    POS_TOP_RIGHT,
                ),
            ]
        ),
    ),
    Output(
        "VerticalMarginsEnable.webp",
        desktop_window("display_settings_screen/vertical_margins_enable_highlight.png"),
    ),
    Output(
        "VerticalMarginsHeight.webp",
        Canvas(
            [
                Placed(
                    desktop_window("display_settings_screen/vertical_margins_height_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("display_settings_screen/vertical_margins_height_dialog.png"),
                    POS_TOP_RIGHT,
                ),
            ]
        ),
    ),
    Output("FadeEnable.webp", desktop_window("display_settings_screen/fade_enable_highlight.png")),
    Output(
        "FadeLength.webp",
        Canvas(
            [
                Placed(desktop_window("display_settings_screen/fade_length_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("display_settings_screen/fade_length_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "SideMargin.webp",
        Canvas(
            [
                Placed(desktop_window("display_settings_screen/side_margin_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("display_settings_screen/side_margin_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "PrompterBackgroundColor.webp",
        Canvas(
            [
                Placed(
                    desktop_window("display_settings_screen/prompter_background_color_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("display_settings_screen/prompter_background_color_dialog.png"),
                    POS_TOP_RIGHT,
                ),
                Placed(desktop_window("prompter_screen/custom_background_color.png"), POS_BOTTOM_LEFT),
            ]
        ),
    ),
    Output(
        "PrompterTextColor.webp",
        Canvas(
            [
                Placed(
                    desktop_window("display_settings_screen/prompter_text_color_highlight.png"), POS_TOP_LEFT
                ),
                Placed(
                    desktop_window("display_settings_screen/prompter_text_color_dialog.png"), POS_TOP_RIGHT
                ),
                Placed(desktop_window("prompter_screen/custom_text_color.png"), POS_BOTTOM_LEFT),
            ]
        ),
    ),
    Output(
        "LockedFeature.webp",
        Canvas(
            [
                Placed(desktop_window("display_settings_screen/locked_feature_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("buy_pro_screen/reading_indicator_boxes.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
]

SCROLL_SETTINGS_SCREEN_COLLAGES: list[Output] = [
    Output(
        "ScrollSpeed.webp",
        Canvas(
            [
                Placed(desktop_window("scroll_settings_screen/scroll_speed_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("scroll_settings_screen/scroll_speed_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "CountdownTimer.webp",
        Canvas(
            [
                Placed(desktop_window("scroll_settings_screen/countdown_timer_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("scroll_settings_screen/countdown_timer_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output("VoiceActivation.webp", desktop_window("scroll_settings_screen/voice_activation_highlight.png")),
    Output(
        "VoiceActivationSensitivity.webp",
        Canvas(
            [
                Placed(
                    desktop_window("scroll_settings_screen/voice_activation_sensitivity_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("scroll_settings_screen/voice_activation_sensitivity_dialog.png"),
                    POS_TOP_RIGHT,
                ),
            ]
        ),
    ),
    Output(
        "AudioDeviceDropdown.webp",
        Canvas(
            [
                Placed(
                    desktop_window("scroll_settings_screen/audio_device_dropdown_highlight.png"), POS_TOP_LEFT
                ),
                Placed(
                    desktop_window("scroll_settings_screen/audio_device_dropdown_dialog.png"), POS_TOP_RIGHT
                ),
            ]
        ),
    ),
    Output(
        "PreviewVoiceActivation.webp",
        Canvas(
            [
                Placed(
                    desktop_window("scroll_settings_screen/preview_voice_activation_highlight.png"),
                    POS_TOP_LEFT,
                ),
                Placed(
                    desktop_window("scroll_settings_screen/preview_voice_activation_active.png"),
                    POS_TOP_RIGHT,
                ),
            ]
        ),
    ),
]

SELECT_SCRIPT_SCREEN_COLLAGES: list[Output] = [
    Output(
        "SavedScriptsScreen.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen_highlights/select_script_button.png"), POS_TOP_LEFT),
                Placed(desktop_window("select_script_screen/foss.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "SaveScript.webp",
        Canvas(
            [
                Placed(desktop_window("home_screen_highlights/save_button.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen_highlights/save_dialog.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "LoadScript.webp",
        Canvas(
            [
                Placed(desktop_window("select_script_screen/load_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("home_screen/loaded_script.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output(
        "DeleteScript.webp",
        Canvas(
            [
                Placed(desktop_window("select_script_screen/delete_highlight.png"), POS_TOP_LEFT),
                Placed(desktop_window("select_script_screen/delete_complete.png"), POS_TOP_RIGHT),
            ]
        ),
    ),
    Output("ImportScript.webp", desktop_window("select_script_screen/import_highlight.png")),
]

PROMPTER_SCREEN_COLLAGES: list[Output] = [
    Output("PrompterScreen.webp", desktop_window("prompter_screen/configured_script.png")),
    Output("PrompterScreenOverlays.webp", desktop_window("prompter_screen/overlays.png")),
    Output("MarkdownAndChapter.webp", desktop_window("prompter_screen/markdown_and_chapter.png")),
]
