from src.domain.builders import EventBuilder
from src.application.ports.repositories import EventRepository
from datetime import datetime


class CreateEventUseCase:
    def __init__(self, event_repo: EventRepository):
        self.event_repo = event_repo

    def execute(self, title: str, date: datetime, location: str, artist_id: int):
        event = EventBuilder(title, artist_id)\
            .at_location(location)\
            .on_date(date)\
            .build()
        return self.event_repo.save(event)
