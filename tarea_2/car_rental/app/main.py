import os
from dotenv import load_dotenv
from db import PgManager
from repositories.user_repository import UserRepository 

load_dotenv()

db_manager = PgManager(
    db_name='postgres',
    user=os.getenv('USER_DB'),
    password=os.getenv('PASSWORD_DB'),
    host='localhost'
)

users_repo = UserRepository(db_manager)
formatted_results = users_repo.get_all()

print("All the users:")
print(formatted_results)