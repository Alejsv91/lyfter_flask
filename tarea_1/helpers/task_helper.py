from flask import abort
from enums.status import Status
from helpers.json_helper import read_json

def validate_status(status: str) -> Status:
    try:
        return Status(str(status).lower().strip())
    except ValueError:
        valid_options = [s.value for s in Status]
        abort(400, description=f"The current status is not allowed, please use: {valid_options}")

def return_filtered_task(task_filter: str | None) -> list[dict]:
    tasks = read_json()
    
    # 1. Primero verificamos si es None (usa 'is None' por convención PEP 8)
    # 2. Solo si NO es None, Python evalúa la segunda parte (.lower().strip())
    if task_filter is None or task_filter.strip() == "":
        return tasks
    
    status_enum = validate_status(task_filter)
    
    return [
        task for task in tasks
        if str(task.get("status", "")).lower().strip() == status_enum.value
    ]


def validate_task_attributes(request_body: dict) -> None:
    if not isinstance(request_body, dict):
        abort(400, description="Request body must be a valid JSON Object")
    
    required_attributes = ['id', 'title', 'description', 'status']
    
    for att in required_attributes:
        value = request_body.get(att)
        if value is None or (isinstance(value, str) and not value.strip()):
            abort(400, description=f"'{att}' attribute is required")
            
    validate_status(request_body.get('status'))
    
def ensure_unique_id(task_id: int, tasks: list[dict]) -> None:
    if any(task.get("id") == task_id for task in tasks):
        abort(409, description=f"A task with id '{task_id}' already exists.")

    
     
    
    
