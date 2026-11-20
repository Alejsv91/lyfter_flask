from enums.status import Status
from helpers.json_helper import read_json
from flask import jsonify

def validate_status(status: str) -> Status:
    try:
        return Status(status.lower().strip())
    except:
        return jsonify("The current status is not allowed, please add the next options: 'in progress', 'pending', 'completed'"), 400
    
def return_filtered_task(task_filter: str) -> list[object]:
    filtered_tasks = read_json()
    try:    
        status_enum = validate_status(task_filter)
        return list(
                filter(lambda task: str(task["status"]).lower().strip() == status_enum, filtered_tasks))
    except:
        return jsonify("Algun error")
        
def validate_task_attributes(request_body: dict):
    if not isinstance(request_body, dict):
        return jsonify(message="Request body must be a valid JSON Object"),400
    
    required_attributes = ['id', 'title', 'description', 'status']
    
    for att in required_attributes:
        value = request_body.get(att)
        
        if value is None or (isinstance(value, str)and not value.strip()):
            return jsonify(message=f"'{att}' attribute is required"), 400
        
    validate_status(request_body.get('status'))