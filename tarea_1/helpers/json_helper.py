import json
from pathlib import Path

CURRENT_PATH = Path(__file__).resolve()
JSON_ROUTE = CURRENT_PATH.parent.parent / "data" / "task.json"

def read_json() -> list[dict]:
    if not JSON_ROUTE.exists():
        return []
        
    with open(JSON_ROUTE, 'r', encoding='utf-8') as file:
        return json.load(file)

def write_json(data: list[dict]) -> None:
    JSON_ROUTE.parent.mkdir(parents=True, exist_ok=True)
    
    with open(JSON_ROUTE, 'w', encoding='utf-8') as file:
        json.dump(data, file, indent=4, ensure_ascii=False)
