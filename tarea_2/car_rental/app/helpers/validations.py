from datetime import date, datetime

def is_valid_string( value: object) -> bool:
        if not isinstance(value, str):
            return False
        
        return bool(value.strip())
        
def is_valid_date(value: object):
    return isinstance(value, date) and not isinstance(value, datetime)

def is_valid_bool(value: object):
    return isinstance(value, bool)