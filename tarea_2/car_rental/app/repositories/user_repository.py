from db import PgManager
from datetime import date

class UserRepository:
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
            if(self.is_valid_string(name) or self.is_valid_string(last_name) or self.is_valid_string(email) or self.is_valid_string(username) or self.is_valid_string(password)):
                pass
                    
        except Exception as error:
            print("Error when we try to create an user", error)
            return False
        
    def is_valid_string(self, value: object) -> bool:
        if not isinstance(value, str):
            return False
        
        return bool(value.strip())

            
                
        
    def get_all(self):
        try:
            results = self.db_manager.execute_query(
                """
	            SET search_path TO lyfter_car_rental;
                
                SELECT * FROM users
                """
            )
            formatted_results = [self._format_user(result) for result in results]
            return formatted_results
        except Exception as error:
                print("Error getting all users from the database", error)
                return False