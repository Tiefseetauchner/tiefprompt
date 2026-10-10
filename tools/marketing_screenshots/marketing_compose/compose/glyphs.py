from PIL import ImageDraw


def draw_chevron_up(draw: ImageDraw.ImageDraw, cx: float, cy: float, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.45
    draw.line(
        [(cx - d, cy + d * 0.6), (cx, cy - d * 0.5), (cx + d, cy + d * 0.6)],
        fill=color,
        width=2,
        joint="curve",
    )


def draw_chevron_down(draw: ImageDraw.ImageDraw, cx: float, cy: float, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.45
    draw.line(
        [(cx - d, cy - d * 0.6), (cx, cy + d * 0.5), (cx + d, cy - d * 0.6)],
        fill=color,
        width=2,
        joint="curve",
    )


def draw_close_x(draw: ImageDraw.ImageDraw, cx: float, cy: float, r: float, color) -> None:
    draw.ellipse((cx - r, cy - r, cx + r, cy + r), outline=color, width=2)
    d = r * 0.42
    draw.line((cx - d, cy - d, cx + d, cy + d), fill=color, width=2)
    draw.line((cx - d, cy + d, cx + d, cy - d), fill=color, width=2)


def draw_signal(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
    half = size / 2
    draw.polygon(
        [(cx - half, cy + half), (cx + half, cy + half), (cx + half, cy - half)],
        fill=color,
    )


def draw_wifi(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
    base_y = cy + size / 2
    width = max(2, int(size * 0.16))
    for scale in (1.0, 0.62):
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


def draw_battery(draw: ImageDraw.ImageDraw, cx: float, cy: float, size: float, color) -> None:
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
