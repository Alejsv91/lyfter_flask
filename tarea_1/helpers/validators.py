from dataclasses import dataclass
from typing import Any, Type
from flask import abort


@dataclass(frozen=True)
class AttributeRule:
    att_name: str
    expected_data_type: Type[Any]


def require_int(value: Any, param_name: str = "parameter") -> int:
    if value is None or isinstance(value, bool):
        abort(400, description=f"Invalid or missing '{param_name}': must be an integer.")
    try:
        return int(value)
    except (ValueError, TypeError):
        abort(400, description=f"Invalid '{param_name}': '{value}' is not a valid integer.")