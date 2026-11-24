from flask import Flask, request, jsonify
from enums.status import Status
from helpers.task_helper import *
from helpers.json_helper import read_json, write_json
from werkzeug.exceptions import HTTPException

app = Flask(__name__)

@app.errorhandler(HTTPException)
def handle_http_exception(error):
    response = {
        "error": error.name,
        "message": error.description,
        "status_code": error.code
    }
    return jsonify(response), error.code

@app.route("/tasks", methods=["GET"])
def get_task():
    task_filter = request.args.get("status")
    return jsonify(return_filtered_task(task_filter)), 200

@app.route("/tasks", methods=["POST"])
def post_task():
    json_body_request = request.json
    validate_task_attributes(json_body_request, None)
    json_body_request['id'] = require_int(json_body_request['id'])
    
    tasks = read_json()
    ensure_unique_id(json_body_request['id'], tasks)
    
    tasks.append(json_body_request)
    write_json(tasks)
    return jsonify(message="task created"),201

@app.route("/tasks/<int:task_id>", methods=["PUT"])
def put_task(task_id: int):
    json_body_request = request.get_json(silent=True)
    result = update_task_by_id(task_id, json_body_request)
    return jsonify(message=result), 200

@app.route("/tasks/<int:task_id>", methods=["DELETE"])
def delete_task(task_id: int):
    deleted_task = delete_task_by_id(task_id)
    return jsonify(message="Task deleted successfully", task=deleted_task), 200

    