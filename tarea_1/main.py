from flask import Flask, request, jsonify
from enums.status import Status
from helpers.task_helper import return_filtered_task, validate_task_attributes, ensure_unique_id
from helpers.json_helper import read_json, write_json

app = Flask(__name__)

@app.route("/tasks", methods=["GET"])
def get_task():
    task_filter = request.args.get("status")
    return jsonify(return_filtered_task(task_filter)), 200

@app.route("/tasks", methods=["POST"])
def post_task():
    json_body_request = request.json
    validate_task_attributes(json_body_request)
    
    tasks = read_json()
    ensure_unique_id(json_body_request['id'], tasks)
    
    tasks.append(json_body_request)
    write_json(tasks)
    return jsonify(message="task created"),200