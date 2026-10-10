from __future__ import annotations

from dataclasses import dataclass

from PIL import Image, ImageDraw

from compose.glyphs import (
    draw_battery,
    draw_chevron_down,
    draw_chevron_up,
    draw_close_x,
    draw_signal,
    draw_wifi,
)
from compose.layer import RGB, TRANSPARENT, Decorator
from compose.typography import draw_centered_text, variable_font

LIGHT_FOREGROUND = (235, 235, 235)


@dataclass(frozen=True)
class Titlebar(Decorator):
    """A desktop-style titlebar strip with a grainy rounded top and window buttons."""

    title: str = "TiefPrompt"
    background: RGB = (221, 206, 216)
    text_color: RGB = (60, 50, 56)
    icon_color: RGB = (120, 110, 115)
    height: int = 44
    font_size: int = 20
    corner_radius: int = 20
    noise_sigma: float = 14
    noise_opacity: float = 0.15

    def apply(self, image: Image.Image) -> Image.Image:
        window = Image.new("RGBA", (image.width, image.height + self.height), TRANSPARENT)
        draw = ImageDraw.Draw(window)
        draw.rounded_rectangle(
            (0, 0, window.width - 1, window.height - 1),
            radius=self.corner_radius,
            fill=self.background + (255,),
            corners=(True, True, False, False),
        )
        window.alpha_composite(self._grain(image.width))
        draw_centered_text(
            draw,
            self.title,
            variable_font(self.font_size),
            (0, 0, image.width, self.height),
            self.text_color,
        )
        self._draw_buttons(draw, image.width)
        window.paste(image, (0, self.height), image)
        return window

    def _grain(self, width: int) -> Image.Image:
        noise = Image.effect_noise((width, self.height), self.noise_sigma).convert("L")
        alpha = noise.point(lambda v: int(abs(v - 128) / 128 * 255 * self.noise_opacity))
        layer = Image.new("RGBA", (width, self.height), TRANSPARENT)
        layer.paste(
            noise.convert("RGB"),
            (0, 0),
            Image.composite(alpha, Image.new("L", alpha.size, 0), self._strip_mask(width)),
        )
        return layer

    def _strip_mask(self, width: int) -> Image.Image:
        mask = Image.new("L", (width, self.height), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            (0, 0, width - 1, self.height - 1),
            radius=self.corner_radius,
            fill=255,
            corners=(True, True, False, False),
        )
        return mask

    def _draw_buttons(self, draw: ImageDraw.ImageDraw, width: int) -> None:
        radius = self.height * 0.28
        spacing = radius * 2.6
        last_cx = width - radius * 2.2
        cy = self.height // 2
        for index, draw_glyph in enumerate((draw_close_x, draw_chevron_up, draw_chevron_down)):
            draw_glyph(draw, int(last_cx - spacing * index), cy, radius, self.icon_color)


@dataclass(frozen=True)
class AndroidSystemBars(Decorator):
    """Status bar and gesture pill drawn over the screenshot, so its size is kept.

    Colors default to the screenshot rows the bars cover, so they suit light and dark screens alike.
    """

    clock: str = "9:41"
    status_height: int = 40
    nav_height: int = 28
    status_background: RGB | None = None
    nav_background: RGB | None = None
    foreground: RGB | None = None
    font_size: int = 18
    side_padding: int = 18
    icon_gap: int = 10

    def apply(self, image: Image.Image) -> Image.Image:
        framed = image.copy()
        draw = ImageDraw.Draw(framed)
        self._draw_status_bar(draw, framed.width, self._status_foreground(image))
        self._draw_gesture_pill(draw, framed.width, framed.height, self._nav_background(image))
        return framed

    def _status_foreground(self, image: Image.Image) -> RGB:
        if self.foreground:
            return self.foreground
        background = self.status_background or _row_color(image, self.status_height)
        return LIGHT_FOREGROUND if _is_dark(background) else (30, 30, 30)

    def _nav_background(self, image: Image.Image) -> RGB:
        return self.nav_background or _row_color(image, image.height - self.nav_height - 1)

    def _draw_status_bar(self, draw: ImageDraw.ImageDraw, width: int, foreground: RGB) -> None:
        font = variable_font(self.font_size, "Medium")
        bbox = draw.textbbox((0, 0), self.clock, font=font)
        draw.text(
            (
                self.side_padding - bbox[0],
                (self.status_height - (bbox[3] - bbox[1])) / 2 - bbox[1],
            ),
            self.clock,
            font=font,
            fill=foreground,
        )

        cy = self.status_height / 2
        size = self.status_height * 0.38
        right = width - self.side_padding
        draw_battery(draw, right - size * 1.1, cy, size, foreground)
        draw_wifi(draw, right - size * 2.2 - self.icon_gap, cy, size, foreground)
        draw_signal(draw, right - size * 3.3 - self.icon_gap * 2, cy, size, foreground)

    def _draw_gesture_pill(self, draw: ImageDraw.ImageDraw, width: int, height: int, background: RGB) -> None:
        color = LIGHT_FOREGROUND if _is_dark(background) else (40, 40, 40)
        pill_w = width * 0.28
        pill_h = max(3, self.nav_height // 6)
        cy = height - self.nav_height / 2
        draw.rounded_rectangle(
            ((width - pill_w) / 2, cy - pill_h / 2, (width + pill_w) / 2, cy + pill_h / 2),
            radius=pill_h / 2,
            fill=color,
        )


def _row_color(image: Image.Image, y: int) -> RGB:
    row = image.convert("RGB").crop((0, y, image.width, y + 1))
    return row.resize((1, 1), Image.Resampling.BOX).getpixel((0, 0))


def _is_dark(color: RGB) -> bool:
    return (color[0] * 299 + color[1] * 587 + color[2] * 114) / 1000 < 128
