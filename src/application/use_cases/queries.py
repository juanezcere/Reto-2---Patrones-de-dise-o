from typing import List
from src.domain.entities import Event, Booking, Artist
from src.application.ports.repositories import EventRepository, BookingRepository, ArtistRepository

class ListArtistsUseCase:
    def __init__(self, artist_repo: ArtistRepository):
        self.artist_repo = artist_repo

    def execute(self) -> List[Artist]:
        return self.artist_repo.list_all()

class ListArtistEventsUseCase:
    def __init__(self, event_repo: EventRepository):
        self.event_repo = event_repo

    def execute(self, artist_id: int) -> List[Event]:
        return self.event_repo.list_by_artist(artist_id)

class ListEventBookingsUseCase:
    def __init__(self, booking_repo: BookingRepository):
        self.booking_repo = booking_repo

    def execute(self, event_id: int) -> List[Booking]:
        return self.booking_repo.list_by_event(event_id)
