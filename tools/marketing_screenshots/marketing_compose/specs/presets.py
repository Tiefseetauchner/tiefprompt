from compose import AndroidSystemBars, DropShadow, Layer, Screenshot, Titlebar


def desktop_window(screenshot: str) -> Layer:
    return DropShadow(Titlebar(Screenshot(screenshot)))


def android_screen(screenshot: str) -> Layer:
    return AndroidSystemBars(Screenshot(screenshot))
