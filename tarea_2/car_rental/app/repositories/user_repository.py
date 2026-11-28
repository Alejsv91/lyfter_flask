from db import PgManager
from datetime import date
from helpers.validations import *
from helpers.sql_loader import load_sql
from db import PgManager
import re
import traceback

class UserRepository:
    db_manager: PgManager
    
    def __init__(self, db_manager):
        self.db_manager = db_manager
        
    def _format_user(self, user_record):
        return {
            "id": user_record[0],
            "name": user_record[1],
            "last_name": user_record[2],
            "email": user_record[3],
            "username": user_record[4],
            "password": user_record[5],
            "birthdate": user_record[6],
            "active_account": user_record[7]
        }
        
    def create_user(self, name: str, last_name: str, email: str, username: str, password: str, birthdate: date, active_account: bool):
        try:
            
            # user creation
            query = load_sql("create_user.sql")
            params = (name, last_name, email, username, password, birthdate, active_account)
            
            result = self.db_manager.execute_query(query, params)
            
            return result[0][0] if result else None
            
        except ValueError as error:
            print(f"Validation Error: {error}")
            return False
                    
        except Exception as error:
            print("Error when we try to create an user", error)
            traceback.print_exc()
            return False
                
        
    def get_all(self):
        try:
            query = load_sql("get_all_users.sql")
            results = self.db_manager.execute_query(query)
            formatted_results = [self._format_user(result) for result in results]
            return formatted_results
        except Exception as error:
                print("Error getting all users from the database", error)
                return False