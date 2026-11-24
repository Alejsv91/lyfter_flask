from flask import abort
from enums.status import Status
from helpers.json_helper import read_json, write_json

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

def validate_task_attributes(request_body: dict, custom_attributes: list[str] | None) -> None:
    if not isinstance(request_body, dict):
        abort(400, description="Request body must be a valid JSON Object")
    
    required_attributes = ['id', 'title', 'description', 'status'] if custom_attributes == None else custom_attributes
    
    for att in required_attributes:
        value = request_body.get(att)
        if value is None or (isinstance(value, str) and not value.strip()):
            abort(400, description=f"'{att}' attribute is required")
            
    validate_status(request_body.get('status'))
    
def ensure_unique_id(task_id: int, tasks: list[dict]) -> None:
    if any(int(task.get("id")) == int(task_id) for task in tasks):
        abort(409, description=f"A task with id '{task_id}' already exists.")

def update_task_by_id(task_id: int, request_body: dict) -> dict:
    validate_task_attributes(request_body, ['title', 'description', 'status'] )
    
    task_id = task_id
    tasks = read_json()
    
    update_task = next((t for t in tasks if t.get("id") == task_id), None)
    
    if update_task is None:
        abort(404, description=f"Task with id '{task_id}' not found.")
    
    # Actualiza TODOS los campos que vengan en request_body (incluyendo "test")
    update_task.update(request_body)
    
    # Normalizamos los campos clave
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