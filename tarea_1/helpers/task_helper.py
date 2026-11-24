from flask import abort
from enums.status import Status
from helpers.json_helper import read_json, write_json

def require_int(value: any, param_name: str = "parameter") -> int:
    if value is None or isinstance(value, bool):
        abort(400, description=f"Invalid or missing '{param_name}': must be an integer.")

    try:
        return int(value)
    except (ValueError, TypeError):
        abort(400, description=f"Invalid '{param_name}': '{value}' is not a valid integer.")

def validate_status(status: str) -> Status:
    try:
        return Status(str(status).lower().strip())
    except ValueError:
        valid_options = [s.value for s in Status]
        abort(400, description=f"The current status is not allowed, please use: {valid_options}")

def return_filtered_task(task_filter: str | None) -> list[dict]:
    tasks = read_json()
    
    if task_filter is None or task_filter.strip() == "":
        return tasks
    
    status_enum = validate_status(task_filter)
    
    return [
        task for task in tasks
        if str(task.get("status", "")).lower().strip() == status_enum.value
    ]

from typing import TypedDict, Type, Any
from flask import abort


class AttributeRule(TypedDict):
    name: str
    type: Type[Any]


from typing import TypedDict, Type, Any
from flask import abort


class AttributeRule(TypedDict):
    name: str
    type: Type[Any]


def validate_task_attributes(
    request_body: dict, 
    custom_attributes: list[AttributeRule] | None = None
) -> None:
    if not isinstance(request_body, dict):
        abort(400, description="Request body must be a valid JSON Object")

    default_attributes: list[AttributeRule] = [
        {"name": "id", "type": int},
        {"name": "title", "type": str},
        {"name": "description", "type": str},
        {"name": "status", "type": str},
    ]

    required_attributes = default_attributes if custom_attributes is None else custom_attributes

    allowed_keys = {att["name"] for att in required_attributes}
    extra_keys = set(request_body.keys()) - allowed_keys

    if extra_keys:
        abort(400, description=f"Unexpected attribute(s) in request body: {', '.join(sorted(extra_keys))}")

    for att in required_attributes:
        name = att["name"]
        expected_type = att["type"]
        value = request_body.get(name)

        is_invalid_type = not isinstance(value, expected_type) or (
            expected_type is int and isinstance(value, bool)
        )
        is_empty_str = isinstance(value, str) and not value.strip()

        if value is None or is_invalid_type or is_empty_str:
            abort(400, description=f"'{name}' attribute is required and must be of type '{expected_type.__name__}'")

    if "status" in request_body:
        validate_status(request_body["status"])
    
def ensure_unique_id(task_id: int, tasks: list[dict]) -> None:
    if any(int(task.get("id")) == int(task_id) for task in tasks):
        abort(409, description=f"A task with id '{task_id}' already exists.")

def update_task_by_id(task_id: int, request_body: dict) -> dict:
    required_attributes: list[AttributeRule] = [
        {"name": "title", "type": str},
        {"name": "description", "type": str},
        {"name": "status", "type": str},
    ]
    
    validate_task_attributes(request_body, required_attributes )
    
    task_id = task_id
    tasks = read_json()
    
    update_task = next((t for t in tasks if t.get("id") == task_id), None)
    
    if update_task is None:
        abort(404, description=f"Task with id '{task_id}' not found.")
    
    update_task.update(request_body)
    
    update_task["title"] = request_body["title"].strip()
    update_task["description"] = request_body["description"].strip()
    update_task["status"] = validate_status(request_body["status"]).value
    
    write_json(tasks)
    return update_task

def delete_task_by_id(task_id: int) -> dict:
    if task_id is None:
        abort(400, description="'id' is required to delete a task.")
        
    tasks = read_json()
    
    task_to_delete = next((t for t in tasks if t.get("id") == task_id), None)
    
    if task_to_delete is None:
        abort(404, description=f"Task with id '{task_id}' not found.")
        
    tasks.remove(task_to_delete)
    write_json(tasks)
    
    return task_to_delete