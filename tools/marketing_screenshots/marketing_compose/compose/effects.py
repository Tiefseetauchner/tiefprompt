from __future__ import annotations

from dataclasses import dataclass

from PIL import Image, ImageDraw, ImageFilter

from compose.layer import RGB, TRANSPARENT, Decorator


@dataclass(frozen=True)
class Crop(Decorator):
    box: tuple[int, int, int, int]

    def apply(self, image: Image.Image) -> Image.Image:
        return image.crop(self.box)


@dataclass(frozen=True)
class ResizeToHeight(Decorator):
    height: int

    def apply(self, image: Image.Image) -> Image.Image:
        width = round(image.width * self.height / image.height)
        return image.resize((width, self.height), Image.Resampling.LANCZOS)


@dataclass(frozen=True)
class ResizeToWidth(Decorator):
    width: int

    def apply(self, image: Image.Image) -> Image.Image:
        height = round(image.height * self.width / image.width)
        return image.resize((self.width, height), Image.Resampling.LANCZOS)


@dataclass(frozen=True)
class DropShadow(Decorator):
    blur_radius: int = 20
    offset: tuple[int, int] = (6, 10)
    opacity: int = 90

    @property
    def padding(self) -> int:
        return self.blur_radius * 2

    def apply(self, image: Image.Image) -> Image.Image:
        canvas = Image.new("RGBA", self._canvas_size(image), TRANSPARENT)
        canvas.paste(Image.new("RGBA", image.size, (0, 0, 0, self.opacity)), self._shadow_origin())
        canvas = canvas.filter(ImageFilter.GaussianBlur(self.blur_radius))
        canvas.paste(image, self._image_origin(), image)
        return canvas

    def _canvas_size(self, image: Image.Image) -> tuple[int, int]:
        return (
            image.width + self.padding * 2 + abs(self.offset[0]),
            image.height + self.padding * 2 + abs(self.offset[1]),
        )

    def _shadow_origin(self) -> tuple[int, int]:
        return self.padding + max(self.offset[0], 0), self.padding + max(self.offset[1], 0)

    def _image_origin(self) -> tuple[int, int]:
        return self.padding + max(-self.offset[0], 0), self.padding + max(-self.offset[1], 0)


@dataclass(frozen=True)
class PillBackground(Decorator):
    color: RGB = (255, 255, 255)
    padding: tuple[int, int] = (24, 12)

    def apply(self, image: Image.Image) -> Image.Image:
        pill = Image.new(
            "RGBA",
            (image.width + self.padding[0] * 2, image.height + self.padding[1] * 2),
            TRANSPARENT,
        )
        ImageDraw.Draw(pill).rounded_rectangle(
            (0, 0, pill.width - 1, pill.height - 1),
            radius=pill.height / 2,
            fill=self.color,
        )
        pill.alpha_composite(image, self.padding)
        return pill
