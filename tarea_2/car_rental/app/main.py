import os
from dotenv import load_dotenv
from db import PgManager
from repositories.user_repository import UserRepository 
from datetime import date, datetime
from flask import Flask, request, jsonify
from models.user import User

app = Flask(__name__)

load_dotenv()

db_manager = PgManager(
    db_name='postgres',
    user=os.getenv('USER_DB'),
    password=os.getenv('PASSWORD_DB'),
    host='localhost'
)

users_repo = UserRepository(db_manager)

@app.route("/users/", methods=["GET"])
def get_users():
    users = users_repo.get_all()
    return jsonify(users), 200

@app.route("/users/", methods=["POST"])
def create_user():
    try:
        json_body_request = request.json
        new_user = User(**json_body_request)
        print("user created: ", new_user.name)
        
        return jsonify(message=f"User created: {new_user.name} {new_user.last_name}"),201
    except (ValueError, TypeError) as error:
        return jsonify({"error": f"Validation Error: {str(error)}"}), 400
                    
    except Exception as error:
        return (
        jsonify({"error": f"Error when we try to create an user: {str(error)}"}),
        500,
    )
        
    # users_repo.create_user()

# bd = date(1991,1,9)
# fecha_str = "09-01-1991"

# # Si el formato es Día-Mes-Año (9 de enero de 1991)
# fecha_date = datetime.strptime(fecha_str, "%d-%m-%Y").date()

# new_user_id = users_repo.create_user("Alejandro", "Solano", "aletest3@gmail.com", "new_username4", "Abcd1234", bd, True)
# print(f"User create id: {new_user_id}")
# # print("All the users:")
# # print(formatted_results)