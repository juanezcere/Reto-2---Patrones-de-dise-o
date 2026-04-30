from dataclasses import dataclass, field
from datetime import datetime
from typing import List, Optional
from enum import Enum


class ServiceCategory(Enum):
    SOUND = "sound"
    TRANSPORT = "transport"
    EQUIPMENT = "equipment"
    STAFF = "staff"


class BookingStatus(Enum):
    PENDING = "pending"
    CONFIRMED = "confirmed"
    CANCELLED = "cancelled"


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
class SoundProvider(Provider):
    sound_power: int


@dataclass
class TransportProvider(Provider):
    vehicle_quantity: int
    vehicle_capacity: int


@dataclass
class StaffProvider(Provider):
    staff_quantity: int
    staff_coordinator: str


@dataclass
class EquipmentProvider(Provider):
    equipment_type: int


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
    status: str = BookingStatus.CANCELLED.value
