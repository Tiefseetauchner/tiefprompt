import argparse
from concurrent.futures import ProcessPoolExecutor
from pathlib import Path

from compose import Output
from specs import ALL_OUTPUTS

TOOL_DIR = Path(__file__).resolve().parent


def _parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Compose marketing images from raw screenshots.")
    parser.add_argument(
        "--input-dir",
        type=Path,
        default=TOOL_DIR,
        help="Directory containing the raw screenshots referenced by the specs.",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=TOOL_DIR / "composed",
        help="Directory to write composed images to.",
    )
    parser.add_argument(
        "--only",
        default=None,
        help="Only render outputs whose path contains this substring.",
    )
    return parser.parse_args()


def _selected_outputs(only: str | None) -> list[Output]:
    if only is None:
        return ALL_OUTPUTS
    return [output for output in ALL_OUTPUTS if only in output.path]


def main() -> None:
    args = _parse_args()
    with ProcessPoolExecutor(32) as executor:
        futures = [
            executor.submit(output.write, args.input_dir, args.output_dir)
            for output in _selected_outputs(args.only)
        ]


if __name__ == "__main__":
    main()
