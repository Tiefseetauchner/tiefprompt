import contextlib
from pathlib import Path

from PIL import ImageDraw, ImageFont

from compose.paths import REPO_ROOT

EXO_FONT = REPO_ROOT / "fonts" / "Exo-VariableFont_wght.ttf"


def variable_font(size: int, weight: str = "Regular", path: Path = EXO_FONT) -> ImageFont.FreeTypeFont:
    font = ImageFont.truetype(str(path), size)
    with contextlib.suppress(OSError):
        font.set_variation_by_name(weight)
    return font


def draw_centered_text(
    draw: ImageDraw.ImageDraw,
    text: str,
    font: ImageFont.FreeTypeFont,
    box: tuple[int, int, int, int],
    color,
) -> None:
    bbox = draw.textbbox((0, 0), text, font=font)
    x = box[0] + (box[2] - box[0] - (bbox[2] - bbox[0])) / 2 - bbox[0]
    y = box[1] + (box[3] - box[1] - (bbox[3] - bbox[1])) / 2 - bbox[1]
    draw.text((x, y), text, font=font, fill=color)


def wrap_words(text: str, font: ImageFont.FreeTypeFont, max_width: int) -> list[str]:
    lines: list[str] = []
    for word in text.split():
        candidate = f"{lines[-1]} {word}" if lines else word
        if lines and font.getlength(candidate) <= max_width:
            lines[-1] = candidate
        else:
            lines.append(word)
    return lines
