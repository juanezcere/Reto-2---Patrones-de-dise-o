from dataclasses import dataclass, field
from datetime import datetime
from typing import List, Optional
from enum import Enum

class ServiceCategory(Enum):
    SOUND = "sound"
    TRANSPORT = "transport"
    EQUIPMENT = "equipment"
    STAFF = "staff"

@dataclass
class Artist:
    id: Optional[int]
    name: str
    email: str

@dataclass
class Provider:
    id: Optional[int]
    name: str
    category: ServiceCategory
    contact_info: str

@dataclass
class Event:
    id: Optional[int]
    title: str
    date: datetime
    location: str
    artist_id: int

@dataclass
class Booking:
    id: Optional[int]
    event_id: int
    provider_id: int
    status: str = "pending" # pending, confirmed, cancelled
