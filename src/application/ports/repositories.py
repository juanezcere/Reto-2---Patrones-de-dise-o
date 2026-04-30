from abc import ABC, abstractmethod
from typing import List, Optional
from src.domain.entities import Artist, Event, Provider, Booking

class ArtistRepository(ABC):
    @abstractmethod
    def save(self, artist: Artist) -> Artist:
        pass

    @abstractmethod
    def get_by_id(self, artist_id: int) -> Optional[Artist]:
        pass

    @abstractmethod
    def list_all(self) -> List[Artist]:
        pass

class EventRepository(ABC):
    @abstractmethod
    def save(self, event: Event) -> Event:
        pass

    @abstractmethod
    def get_by_id(self, event_id: int) -> Optional[Event]:
        pass

    @abstractmethod
    def list_by_artist(self, artist_id: int) -> List[Event]:
        pass

class ProviderRepository(ABC):
    @abstractmethod
    def save(self, provider: Provider) -> Provider:
        pass

    @abstractmethod
    def list_by_category(self, category: str) -> List[Provider]:
        pass

    @abstractmethod
    def get_by_id(self, provider_id: int) -> Optional[Provider]:
        pass

class BookingRepository(ABC):
    @abstractmethod
    def save(self, booking: Booking) -> Booking:
        pass

    @abstractmethod
    def list_by_event(self, event_id: int) -> List[Booking]:
        pass
