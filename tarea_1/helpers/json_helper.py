import json
from pathlib import Path

CURRENT_PATH = Path(__file__).resolve()

JSON_ROUTE = CURRENT_PATH.parent.parent / "data" / "task.json"

def read_json():
    with open(JSON_ROUTE, 'r', encoding='utf-8') as file:
        return json.load(file)
    
    
