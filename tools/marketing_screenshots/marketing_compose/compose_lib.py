"""Reusable building blocks for composing marketing window screenshots.

Mirrors the shape of integration_test/scenarios/scenario.dart's
`runScenario`: a couple of small, reusable functions plus declarative specs
(see specs.py) that describe what to render, not how.

Window decoration is owned by `Chrome` subclasses: a spec picks one, and
the chrome decides everything about how the raw screenshot is framed.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

REPO_ROOT = Path(__file__).resolve().parents[3]
SCREENSHOT_SUPERSAMPLE = 2
EXO_FONT = REPO_ROOT / "fonts" / "Exo-VariableFont_wght.ttf"


def _variable_font(path: Path, size: int, weight: str = "Regular") -> ImageFont.FreeTypeFont:
    font = ImageFont.truetype(str(path), size)
    try:
        font.set_variation_by_name(weight)
    except OSError:
        pass
    return font


def _draw_centered_text(
    draw: ImageDraw.ImageDraw,
    text: str,
    font: ImageFont.FreeTypeFont,
    box: tuple[int, int, int, int],
    color,
) -> None:
    bbox = draw.textbbox((0, 0), text, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    x = box[0] + (box[2] - box[0] - text_w) / 2 - bbox[0]
    y = box[1] + (box[3] - box[1] - text_h) / 2 - bbox[1]
    draw.text((x, y), text, font=font, fill=color)


def add_drop_shadow(
    image: Image.Image,
    blur_radius: int = 20,
    offset: tuple[int, int] = (6, 10),
    opacity: int = 90,
) -> Image.Image:
    """Pads `image` and adds a soft drop shadow behind it on a transparent canvas."""
    pad = blur_radius * 2
    canvas_w = image.width + pad * 2 + abs(offset[0])
    canvas_h = image.height + pad * 2 + abs(offset[1])

    shadow_layer = Image.new("RGBA", (canvas_w, canvas_h), (0, 0, 0, 0))
    shadow_shape = Image.new("RGBA", image.size, (0, 0, 0, opacity))
    shadow_x = pad + max(offset[0], 0)
    shadow_y = pad + max(offset[1], 0)
    shadow_layer.paste(shadow_shape, (shadow_x, shadow_y))
    shadow_layer = shadow_layer.filter(ImageFilter.GaussianBlur(blur_radius))

    window_x = pad + max(-offset[0], 0)
    window_y = pad + max(-offset[1], 0)
    shadow_layer.paste(image, (window_x, window_y), image if image.mode == "RGBA" else None)
    return shadow_layer


class Chrome(ABC):
    """Frames a raw screenshot: decoration, padding, shadow — all of it."""

    @abstractmethod
    def render(self, image: Image.Image, title: str) -> Image.Image:
        """Returns a new image of `image` wearing this chrome."""


@dataclass(frozen=True)
class NoneChrome(Chrome):
    """Passes the screenshot through untouched."""

    def render(self, image: Image.Image, title: str) -> Image.Image:
        return image


@dataclass(frozen=True)
class ShadowOnlyChrome(Chrome):
    """No decoration, but keeps the soft drop shadow of a floating window."""

    blur_radius: int = 20
    offset: tuple[int, int] = (6, 10)
    opacity: int = 90

    def render(self, image: Image.Image, title: str) -> Image.Image:
        return add_drop_shadow(image, self.blur_radius, self.offset, self.opacity)


@dataclass(frozen=True)
class TitlebarChrome(Chrome):
    """A desktop-style window: rounded titlebar strip, buttons, drop shadow."""

    background: tuple[int, int, int] = (221, 206, 216)
    text_color: tuple[int, int, int] = (60, 50, 56)
    icon_color: tuple[int, int, int] = (120, 110, 115)
    height: int = 44
    font_path: Path = EXO_FONT
    font_size: int = 20
    corner_radius: int = 20
    noise_sigma: float = 14
    noise_opacity: float = 0.15
    shadow: bool = True

    def render(self, image: Image.Image, title: str) -> Image.Image:
        result = Image.new("RGBA", (image.width, image.height + self.height), (0, 0, 0, 0))
        draw = ImageDraw.Draw(result)
        draw.rounded_rectangle(
            (0, 0, result.width - 1, result.height - 1),
            radius=self.corner_radius,
            fill=self.background + (255,),
            corners=(True, True, False, False),
        )
        result.alpha_composite(self._noise(image.width))

        _draw_centered_text(
            draw,
            title,
            _variable_font(self.font_path, self.font_size),
            (0, 0, image.width, self.height),
            self.text_color,
        )
        self._draw_buttons(draw, image.width)

        result.paste(image, (0, self.height), image if image.mode == "RGBA" else None)
        return add_drop_shadow(result) if self.shadow else result

    def _noise(self, width: int) -> Image.Image:
        """A subtle grain layer shaped like the titlebar's rounded-top strip."""
        grain = Image.effect_noise((width, self.height), self.noise_sigma).convert("L")
        alpha = grain.point(lambda v: int(abs(v - 128) / 128 * 255 * self.noise_opacity))
        mask = Image.new("L", (width, self.height), 0)
        ImageDraw.Draw(mask).rounded_rectangle(
            (0, 0, width - 1, self.height - 1),
            radius=self.corner_radius,
            fill=255,
            corners=(True, True, False, False),
        )
        layer = Image.new("RGBA", (width, self.height), (0, 0, 0, 0))
        layer.paste(
            grain.convert("RGB"),
            (0, 0),
            Image.composite(alpha, Image.new("L", mask.size, 0), mask),
        )
        return layer

    def _button_centers(self, image_width: int) -> list[tuple[int, int]]:
        radius = self.height * 0.28
        spacing = radius * 2.6
        right_padding = radius * 2.2
        cy = self.height // 2
        last_cx = image_width - right_padding
        return [(int(last_cx - spacing * i), cy) for i in reversed(range(3))]

    def _draw_buttons(self, draw: ImageDraw.ImageDraw, image_width: int) -> None:
        radius = self.height * 0.28
        drawers = (_draw_chevron_down, _draw_chevron_up, _draw_close_x)
        for (cx, cy), icon_drawer in zip(self._button_centers(image_width), drawers):
            icon_drawer(draw, cx, cy, radius, self.icon_color)


def _draw_chevron_up(draw: ImageDraw.ImageDraw, cx: int, cy: int, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.45
    draw.line(
        [(cx - d, cy + d * 0.6), (cx, cy - d * 0.5), (cx + d, cy + d * 0.6)],
        fill=color,
        width=2,
        joint="curve",
    )


def _draw_chevron_down(draw: ImageDraw.ImageDraw, cx: int, cy: int, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.45
    draw.line(
        [(cx - d, cy - d * 0.6), (cx, cy + d * 0.5), (cx + d, cy - d * 0.6)],
        fill=color,
        width=2,
        joint="curve",
    )


def _draw_close_x(draw: ImageDraw.ImageDraw, cx: int, cy: int, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.42
    draw.line((cx - d, cy - d, cx + d, cy + d), fill=color, width=2)
    draw.line((cx - d, cy + d, cx + d, cy - d), fill=color, width=2)


def _is_dark(color: tuple[int, int, int]) -> bool:
    return (color[0] * 299 + color[1] * 587 + color[2] * 114) / 1000 < 128


@dataclass(frozen=True)
class AndroidChrome(Chrome):
    """A phone-style frame: status bar on top, gesture pill at the bottom.

    Both bars are drawn over the screenshot rather than added around it, so
    the output keeps the input's aspect ratio. Colors default to the rows
    the bars cover, so they blend into light and dark screenshots alike.
    """

    clock: str = "9:41"
    status_height: int = 40
    nav_height: int = 28
    status_background: tuple[int, int, int] | None = None
    nav_background: tuple[int, int, int] | None = None
    foreground: tuple[int, int, int] | None = None
    font_path: Path = EXO_FONT
    font_size: int = 18
    side_padding: int = 18
    icon_gap: int = 10

    def render(self, image: Image.Image, title: str) -> Image.Image:
        result = image.copy()

        status_bg = self.status_background or self._edge_color(image, self.status_height)
        nav_bg = self.nav_background or self._edge_color(
            image, image.height - self.nav_height - 1
        )
        fg = self.foreground or ((235, 235, 235) if _is_dark(status_bg) else (30, 30, 30))

        draw = ImageDraw.Draw(result)

        self._draw_status_bar(draw, result.width, fg)
        self._draw_gesture_pill(draw, result.width, result.height, nav_bg)
        return result

    @staticmethod
    def _edge_color(image: Image.Image, y: int) -> tuple[int, int, int]:
        row = image.convert("RGB").crop((0, y, image.width, y + 1))
        return row.resize((1, 1), Image.Resampling.BOX).getpixel((0, 0))

    def _draw_status_bar(self, draw: ImageDraw.ImageDraw, width: int, fg) -> None:
        font = _variable_font(self.font_path, self.font_size, "Medium")
        bbox = draw.textbbox((0, 0), self.clock, font=font)
        draw.text(
            (
                self.side_padding - bbox[0],
                (self.status_height - (bbox[3] - bbox[1])) / 2 - bbox[1],
            ),
            self.clock,
            font=font,
            fill=fg,
        )

        cy = self.status_height / 2
        size = self.status_height * 0.38
        right = width - self.side_padding
        _draw_battery(draw, right - size * 1.1, cy, size, fg)
        _draw_wifi(draw, right - size * 2.2 - self.icon_gap, cy, size, fg)
        _draw_signal(draw, right - size * 3.3 - self.icon_gap * 2, cy, size, fg)

    def _draw_gesture_pill(
        self, draw: ImageDraw.ImageDraw, width: int, height: int, background
    ) -> None:
        color = (235, 235, 235) if _is_dark(background) else (40, 40, 40)
        pill_w = width * 0.28
        pill_h = max(3, self.nav_height // 6)
        cy = height - self.nav_height / 2
        draw.rounded_rectangle(
            ((width - pill_w) / 2, cy - pill_h / 2, (width + pill_w) / 2, cy + pill_h / 2),
            radius=pill_h / 2,
            fill=color,
        )


def _draw_signal(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
    half = size / 2
    draw.polygon(
        [(cx - half, cy + half), (cx + half, cy + half), (cx + half, cy - half)],
        fill=color,
    )


def _draw_wifi(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
    base_y = cy + size / 2
    width = max(2, int(size * 0.16))
    for i, scale in enumerate((1.0, 0.62)):
        r = size * scale
        draw.arc(
            (cx - r, base_y - r, cx + r, base_y + r),
            start=225,
            end=315,
            fill=color,
            width=width,
        )
    dot = size * 0.13
    draw.ellipse((cx - dot, base_y - dot * 2, cx + dot, base_y), fill=color)


def _draw_battery(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
    body_w = size * 1.1
    body_h = size * 0.62
    left = cx - body_w / 2
    top = cy - body_h / 2
    outline = max(2, int(size * 0.12))
    draw.rounded_rectangle(
        (left, top, left + body_w, top + body_h),
        radius=size * 0.14,
        outline=color,
        width=outline,
    )
    nub_h = body_h * 0.4
    draw.rounded_rectangle(
        (
            left + body_w + outline * 0.5,
            cy - nub_h / 2,
            left + body_w + outline * 1.8,
            cy + nub_h / 2,
        ),
        radius=outline * 0.5,
        fill=color,
    )
    inset = outline * 1.6
    draw.rectangle(
        (left + inset, top + inset, left + body_w * 0.72, top + body_h - inset),
        fill=color,
    )


DEFAULT_CHROME = TitlebarChrome()
NO_CHROME = NoneChrome()
ANDROID_CHROME = AndroidChrome()


@dataclass(frozen=True)
class Position:
    x: int
    y: int


@dataclass(frozen=True)
class WindowSpec:
    input: str
    title: str
    position: Position
    crop: tuple[int, int, int, int] | None = None
    chrome: Chrome = DEFAULT_CHROME


@dataclass(frozen=True)
class CollageSpec:
    output: str
    windows: list[WindowSpec] = field(default_factory=list)


def _load_image(path: str, input_dir: Path) -> Image.Image:
    image = Image.open(input_dir / path).convert("RGBA")
    if SCREENSHOT_SUPERSAMPLE != 1:
        image = image.resize(
            (image.width // SCREENSHOT_SUPERSAMPLE, image.height // SCREENSHOT_SUPERSAMPLE),
            Image.Resampling.LANCZOS,
        )
    return image


def render_window(spec: WindowSpec, input_dir: Path) -> Image.Image:
    image = _load_image(spec.input, input_dir)
    if spec.crop is not None:
        image = image.crop(spec.crop)
    return spec.chrome.render(image, spec.title)


def compose_collage(spec: CollageSpec, input_dir: Path, output_dir: Path) -> Path:
    rendered = [(w.position, render_window(w, input_dir)) for w in spec.windows]

    canvas_w = max(pos.x + img.width for pos, img in rendered)
    canvas_h = max(pos.y + img.height for pos, img in rendered)
    canvas = Image.new("RGBA", (canvas_w, canvas_h), (0, 0, 0, 0))
    for pos, img in rendered:
        canvas.alpha_composite(img, (pos.x, pos.y))

    output_path = output_dir / spec.output
    output_path.parent.mkdir(parents=True, exist_ok=True)
    canvas.save(output_path, quality=90, method=6, optimize=True)
    return output_path
