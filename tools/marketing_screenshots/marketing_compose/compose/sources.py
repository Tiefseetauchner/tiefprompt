from __future__ import annotations

from dataclasses import dataclass
from math import ceil
from pathlib import Path

from PIL import Image, ImageDraw

from compose.layer import RGB, TRANSPARENT, Layer
from compose.paths import REPO_ROOT
from compose.typography import variable_font, wrap_words


@dataclass(frozen=True)
class Screenshot(Layer):
    path: str

    def render(self, screenshots_dir: Path) -> Image.Image:
        return Image.open(screenshots_dir / self.path).convert("RGBA")


@dataclass(frozen=True)
class Asset(Layer):
    path: str

    def render(self, screenshots_dir: Path) -> Image.Image:
        return Image.open(REPO_ROOT / self.path).convert("RGBA")


@dataclass(frozen=True)
class Text(Layer):
    text: str
    size: int
    color: RGB
    weight: str = "Regular"
    max_width: int | None = None
    line_spacing: float = 1.2

    def render(self, screenshots_dir: Path) -> Image.Image:
        font = variable_font(self.size, self.weight)
        lines = self._lines(font)
        ascent, descent = font.getmetrics()
        line_height = round(self.size * self.line_spacing)

        width = max(ceil(font.getlength(line)) for line in lines)
        height = ascent + descent + line_height * (len(lines) - 1)
        image = Image.new("RGBA", (width, height), TRANSPARENT)
        draw = ImageDraw.Draw(image)
        for index, line in enumerate(lines):
            draw.text((0, ascent + index * line_height), line, font=font, fill=self.color, anchor="ls")
        return image

    def _lines(self, font) -> list[str]:
        if self.max_width is None:
            return [self.text]
        return wrap_words(self.text, font, self.max_width)


@dataclass(frozen=True)
class HorizontalGradient(Layer):
    size: tuple[int, int]
    start: RGB
    end: RGB

    def render(self, screenshots_dir: Path) -> Image.Image:
        left_to_right = Image.linear_gradient("L").rotate(90).resize(self.size)
        return Image.composite(
            Image.new("RGBA", self.size, self.end),
            Image.new("RGBA", self.size, self.start),
            left_to_right,
        )
