import os
from dotenv import load_dotenv
from db import PgManager
from repositories.user_repository import UserRepository 
from datetime import date, datetime

load_dotenv()

db_manager = PgManager(
    db_name='postgres',
    user=os.getenv('USER_DB'),
    password=os.getenv('PASSWORD_DB'),
    host='localhost'
)

users_repo = UserRepository(db_manager)
# formatted_results = users_repo.get_all()

bd = date(1991,1,9)
fecha_str = "09-01-1991"

# Si el formato es Día-Mes-Año (9 de enero de 1991)
fecha_date = datetime.strptime(fecha_str, "%d-%m-%Y").date()

new_user_id = users_repo.create_user("Alejandro", "Solano", "aletest3@gmail.com", "new_username4", "Abcd1234", bd, True)
print(f"User create id: {new_user_id}")
# print("All the users:")
# print(formatted_results)