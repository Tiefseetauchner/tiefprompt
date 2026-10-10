from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from pathlib import Path

from PIL import Image

RGB = tuple[int, int, int]
TRANSPARENT = (0, 0, 0, 0)


class Layer(ABC):
    @abstractmethod
    def render(self, screenshots_dir: Path) -> Image.Image: ...


@dataclass(frozen=True)
class Decorator(Layer, ABC):
    inner: Layer

    def render(self, screenshots_dir: Path) -> Image.Image:
        return self.apply(self.inner.render(screenshots_dir))

    @abstractmethod
    def apply(self, image: Image.Image) -> Image.Image: ...
