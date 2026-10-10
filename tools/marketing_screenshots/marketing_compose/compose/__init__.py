"""Marketing images as trees of layers.

Sources (screenshots, assets, text, gradients) produce an image; decorators wrap any layer to apply
one effect each (titlebar, shadow, resize, ...); layouts place layers next to or on top of each other.
"""

from compose.chrome import AndroidSystemBars, Titlebar
from compose.effects import Crop, DropShadow, PillBackground, ResizeToHeight, ResizeToWidth
from compose.layer import Decorator, Layer
from compose.layout import Canvas, Placed, Position, Row
from compose.output import Output, in_folder
from compose.sources import Asset, HorizontalGradient, Screenshot, Text

__all__ = [
    "AndroidSystemBars",
    "Asset",
    "Canvas",
    "Crop",
    "Decorator",
    "DropShadow",
    "HorizontalGradient",
    "Layer",
    "Output",
    "PillBackground",
    "Placed",
    "Position",
    "ResizeToHeight",
    "ResizeToWidth",
    "Row",
    "Screenshot",
    "Text",
    "Titlebar",
    "in_folder",
]
