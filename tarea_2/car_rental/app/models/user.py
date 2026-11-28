from datetime import date
from helpers.validations import *
from datetime import date, datetime

class User:
    def __init__(self, name: str, last_name: str, email: str, username: str, 
                 password: str, birthdate: date, active_account: bool):
        
        string_fields ={
                "name":name,
                "last_name": last_name,
                "email": email,
                "username": username,
                "password": password
            }
        birthdate = datetime.strptime(birthdate, "%d-%m-%Y").date()
        # inputs validation
        for field_name, value in string_fields.items():
            if not is_valid_string(value):
                raise ValueError(f"Current parameter {field_name} must be a string") 
        
        if not is_valid_email(email):
            raise ValueError(f"Current email does not have the correct format")
        
        if not is_valid_date(birthdate):
            raise ValueError(f"birthdate must be a valid date")
        
        if not is_valid_bool(active_account):
            raise ValueError(f"active_account should be a boolean")
        
        self.name = name
        self.last_name = last_name
        self.email = email
        self.username = username
        self.password = password
        self.birthdate = birthdate
        self.active_account = active_account