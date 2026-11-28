from pathlib import Path

QUERIES_DIR = Path(__file__).resolve().parent.parent / "queries"

def load_sql(filename: str) -> str:
    file_path = QUERIES_DIR / filename
    return file_path.read_text(encoding="utf-8")
