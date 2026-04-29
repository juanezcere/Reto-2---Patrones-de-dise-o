from src.domain.entities import Event
from src.application.ports.repositories import EventRepository
from datetime import datetime

class CreateEventUseCase:
    def __init__(self, event_repo: EventRepository):
        self.event_repo = event_repo

    def execute(self, title: str, date: datetime, location: str, artist_id: int) -> Event:
        event = Event(id=None, title=title, date=date, location=location, artist_id=artist_id)
        return self.event_repo.save(event)
