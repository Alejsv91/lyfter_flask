from flask import Flask, request, jsonify
from enums.status import Status
from helpers.task_helper import return_filtered_task, validate_task_attributes

app = Flask(__name__)

@app.route("/tasks", methods=["GET"])
def get_task():
    task_filter = str(request.args.get("status")).lower().strip()
    print(task_filter)
    if task_filter is not None:
        return return_filtered_task(task_filter)
    else:
        print("There is no filter")

@app.route("/tasks", methods=["POST"])
def post_task():
    validate_task_attributes(request.json)
    
    # if filter(lambda task: task["id"] == request_body["id"]):
    #     return jsonify(message='Current id exist in our data. Please use a different db'), 400
        
    
    
    
    
    
    
    
    print("this is the request body: ", request_body)
    return request_body
    