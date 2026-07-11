import argparse
from pathlib import Path

from compose_lib import compose_collage
from specs import ALL_COLLAGES

TOOL_DIR = Path(__file__).resolve().parent


def main() -> None:
    parser = argparse.ArgumentParser(description="Compose marketing window screenshots.")
    parser.add_argument(
        "--input-dir",
        type=Path,
        default=TOOL_DIR,
        help="Directory containing the raw screenshots referenced by specs.py.",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=TOOL_DIR / "composed",
        help="Directory to write composed collages to.",
    )
    parser.add_argument(
        "--only",
        default=None,
        help="Only render collages whose output filename contains this substring.",
    )
    args = parser.parse_args()

    collages = ALL_COLLAGES
    if args.only:
        collages = [c for c in collages if args.only in c.output]

    for spec in collages:
        output_path = compose_collage(spec, args.input_dir, args.output_dir)
        print(f"wrote {output_path}")


if __name__ == "__main__":
    main()
