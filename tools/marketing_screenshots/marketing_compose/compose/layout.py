from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path

from PIL import Image

from compose.layer import TRANSPARENT, Layer


@dataclass(frozen=True)
class Position:
    x: int
    y: int


@dataclass(frozen=True)
class Placed:
    """`anchor` picks which point of the layer sits on `position`, as fractions of its size."""

    layer: Layer
    position: Position
    anchor: tuple[float, float] = (0, 0)

    def top_left(self, image: Image.Image) -> tuple[int, int]:
        return (
            round(self.position.x - image.width * self.anchor[0]),
            round(self.position.y - image.height * self.anchor[1]),
        )


@dataclass(frozen=True)
class Canvas(Layer):
    """Stacks children back to front. Without a `size` it grows to fit them; with one, it clips them."""

    children: list[Placed] = field(default_factory=list)
    size: tuple[int, int] | None = None

    def render(self, screenshots_dir: Path) -> Image.Image:
        rendered = [(child.top_left(image), image) for child, image in self._render_children(screenshots_dir)]
        canvas = Image.new("RGBA", self.size or _bounding_size(rendered), TRANSPARENT)
        for top_left, image in rendered:
            canvas.alpha_composite(image, top_left)
        return canvas

    def _render_children(self, screenshots_dir: Path) -> list[tuple[Placed, Image.Image]]:
        return [(child, child.layer.render(screenshots_dir)) for child in self.children]


@dataclass(frozen=True)
class Row(Layer):
    """Lays children out left to right, vertically centered."""

    children: list[Layer] = field(default_factory=list)
    gap: int = 0

    def render(self, screenshots_dir: Path) -> Image.Image:
        images = [child.render(screenshots_dir) for child in self.children]
        width = sum(image.width for image in images) + self.gap * (len(images) - 1)
        height = max(image.height for image in images)

        row = Image.new("RGBA", (width, height), TRANSPARENT)
        x = 0
        for image in images:
            row.alpha_composite(image, (x, (height - image.height) // 2))
            x += image.width + self.gap
        return row


def _bounding_size(rendered: list[tuple[tuple[int, int], Image.Image]]) -> tuple[int, int]:
    return (
        max(x + image.width for (x, _), image in rendered),
        max(y + image.height for (_, y), image in rendered),
    )
