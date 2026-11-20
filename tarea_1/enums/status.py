from enum import StrEnum

class Status(StrEnum):
    PENDING = 'pending'
    COMPLETED = 'completed'
    IN_PROGRESS = 'in progress'