from __future__ import annotations

import sys
from pathlib import Path

# Make the package importable without relying on `pip install -e .`
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from campus_intel.pipeline import run_all  # noqa: E402


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    result = run_all(root=root)
    print("Pipeline complete.")
    print(f"- DB: {result['db_path']}")
    print(f"- Processed exports: {result['processed_dir']}")
    print(f"- Metrics: {result['metrics']}")


if __name__ == "__main__":
    main()

