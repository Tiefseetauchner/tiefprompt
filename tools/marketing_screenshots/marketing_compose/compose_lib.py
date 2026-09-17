"""Reusable building blocks for composing marketing window screenshots.

Mirrors the shape of integration_test/scenarios/scenario.dart's
`runScenario`: a couple of small, reusable functions plus declarative specs
(see specs.py) that describe what to render, not how.
"""

from __future__ import annotations

import math
from dataclasses import dataclass, field
from pathlib import Path

from PIL import Image, ImageDraw, ImageFilter, ImageFont

REPO_ROOT = Path(__file__).resolve().parents[3]
SCREENSHOT_SUPERSAMPLE = 2

@dataclass(frozen=True)
class TitlebarSkin:
    background: tuple[int, int, int] = (221, 206, 216)
    text_color: tuple[int, int, int] = (60, 50, 56)
    icon_color: tuple[int, int, int] = (120, 110, 115)
    height: int = 44
    font_path: Path = REPO_ROOT / "fonts" / "Exo-VariableFont_wght.ttf"
    font_size: int = 20
    corner_radius: int = 20
    noise_sigma: float = 14
    noise_opacity: float = 0.15


DEFAULT_SKIN = TitlebarSkin()


def _icon_button_centers(image_width: int, skin: TitlebarSkin) -> list[tuple[int, int]]:
    radius = skin.height * 0.28
    spacing = radius * 2.6
    right_padding = radius * 2.2
    cy = skin.height // 2
    last_cx = image_width - right_padding
    return [(int(last_cx - spacing * i), cy) for i in reversed(range(3))]


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


_ICON_DRAWERS = (_draw_chevron_down, _draw_chevron_up, _draw_close_x)


def _titlebar_noise(width: int, skin: TitlebarSkin) -> Image.Image:
    """A subtle grain layer shaped like the titlebar's rounded-top strip."""
    grain = Image.effect_noise((width, skin.height), skin.noise_sigma).convert("L")
    alpha = grain.point(lambda v: int(abs(v - 128) / 128 * 255 * skin.noise_opacity))
    mask = Image.new("L", (width, skin.height), 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        (0, 0, width - 1, skin.height - 1),
        radius=skin.corner_radius,
        fill=255,
        corners=(True, True, False, False),
    )
    layer = Image.new("RGBA", (width, skin.height), (0, 0, 0, 0))
    layer.paste(grain.convert("RGB"), (0, 0), Image.composite(alpha, Image.new("L", mask.size, 0), mask))
    return layer


def draw_titlebar(image: Image.Image, title: str, skin: TitlebarSkin = DEFAULT_SKIN) -> Image.Image:
    """Returns a new image with a titlebar strip added above `image`."""
    result = Image.new("RGBA", (image.width, image.height + skin.height), (0, 0, 0, 0))
    draw = ImageDraw.Draw(result)
    draw.rounded_rectangle(
        (0, 0, result.width - 1, result.height - 1),
        radius=skin.corner_radius,
        fill=skin.background + (255,),
        corners=(True, True, False, False),
    )
    result.alpha_composite(_titlebar_noise(image.width, skin))

    # As Exo is a variable font, we need to set the weight explicitly
    font = ImageFont.truetype(str(skin.font_path), skin.font_size)
    font.set_variation_by_name('Regular')
    text_bbox = draw.textbbox((0, 0), title, font=font)
    text_w = text_bbox[2] - text_bbox[0]
    text_h = text_bbox[3] - text_bbox[1]
    draw.text(
        ((image.width - text_w) / 2 - text_bbox[0], (skin.height - text_h) / 2 - text_bbox[1]),
        title,
        font=font,
        fill=skin.text_color,
    )

    radius = skin.height * 0.28
    for (cx, cy), icon_drawer in zip(_icon_button_centers(image.width, skin), _ICON_DRAWERS):
        icon_drawer(draw, cx, cy, radius, skin.icon_color)

    result.paste(image, (0, skin.height), image if image.mode == "RGBA" else None)
    return result


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
    skin: TitlebarSkin = DEFAULT_SKIN


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
    image = (
        _load_image(spec.input, input_dir)
    )
    if spec.crop is not None:
        image = image.crop(spec.crop)
    windowed = draw_titlebar(image, spec.title, spec.skin)
    return add_drop_shadow(windowed)


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
