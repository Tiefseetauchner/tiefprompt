from __future__ import annotations

import dataclasses
from dataclasses import dataclass
from pathlib import Path

from PIL import Image

from compose.layer import Layer

OPAQUE_FORMATS = {".jpg", ".jpeg"}


@dataclass(frozen=True)
class Output:
    path: str
    layer: Layer

    def in_folder(self, folder: str) -> Output:
        return dataclasses.replace(self, path=f"{folder}/{self.path}")

    def write(self, screenshots_dir: Path, output_dir: Path) -> Path:
        target = output_dir / self.path
        target.parent.mkdir(parents=True, exist_ok=True)
        _encodable(self.layer.render(screenshots_dir), target).save(
            target, quality=90, method=6, optimize=True
        )
        print(f"Wrote {target}")
        return target


def _encodable(image: Image.Image, target: Path) -> Image.Image:
    if target.suffix.lower() in OPAQUE_FORMATS:
        return image.convert("RGB")
    return image


def in_folder(folder: str, outputs: list[Output]) -> list[Output]:
    return [output.in_folder(folder) for output in outputs]
