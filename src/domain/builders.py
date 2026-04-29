from abc import ABC, abstractmethod
from datetime import datetime
from src.domain.entities import Event


class IBuilder(ABC):
    @abstractmethod
    def build(self) -> Event:
        raise NotImplementedError


class EventBuilder(IBuilder):
    def __init__(self, title: str, artist_id: int):
        self._title = title
        self._artist_id = artist_id
        self._date = datetime.now()
        self._location = "TBD"
        self._id = None

    def at_location(self, location: str) -> "EventBuilder":
        self._location = location
        return self

    def on_date(self, date: datetime) -> "EventBuilder":
        self._date = date
        return self

    def build(self) -> Event:
        return Event(
            id=self._id,
            title=self._title,
            date=self._date,
            location=self._location,
            artist_id=self._artist_id
        )
