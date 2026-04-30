from sqlalchemy.orm import Session
from typing import List, Optional
from src.domain.entities import Artist, Event, Provider, Booking, ServiceCategory
from src.application.ports.repositories import ArtistRepository, EventRepository, ProviderRepository, BookingRepository
from src.infrastructure.adapters.db.models import ArtistModel, EventModel, ProviderModel, BookingModel

class SQLAlchemyArtistRepository(ArtistRepository):
    def __init__(self, db: Session):
        self.db = db

    def save(self, artist: Artist) -> Artist:
        model = ArtistModel(name=artist.name, email=artist.email)
        self.db.add(model)
        self.db.commit()
        self.db.refresh(model)
        artist.id = model.id
        return artist

    def get_by_id(self, artist_id: int) -> Optional[Artist]:
        model = self.db.query(ArtistModel).filter(ArtistModel.id == artist_id).first()
        if model:
            return Artist(id=model.id, name=model.name, email=model.email)
        return None

    def list_all(self) -> List[Artist]:
        models = self.db.query(ArtistModel).all()
        return [Artist(id=m.id, name=m.name, email=m.email) for m in models]

class SQLAlchemyEventRepository(EventRepository):
    def __init__(self, db: Session):
        self.db = db

    def save(self, event: Event) -> Event:
        model = EventModel(title=event.title, date=event.date, location=event.location, artist_id=event.artist_id)
        self.db.add(model)
        self.db.commit()
        self.db.refresh(model)
        event.id = model.id
        return event

    def get_by_id(self, event_id: int) -> Optional[Event]:
        model = self.db.query(EventModel).filter(EventModel.id == event_id).first()
        if model:
            return Event(id=model.id, title=model.title, date=model.date, location=model.location, artist_id=model.artist_id)
        return None

    def list_by_artist(self, artist_id: int) -> List[Event]:
        models = self.db.query(EventModel).filter(EventModel.artist_id == artist_id).all()
        return [Event(id=m.id, title=m.title, date=m.date, location=m.location, artist_id=m.artist_id) for m in models]

class SQLAlchemyProviderRepository(ProviderRepository):
    def __init__(self, db: Session):
        self.db = db

    def save(self, provider: Provider) -> Provider:
        model = ProviderModel(
            name=provider.name, 
            category=provider.category, 
            contact_info=provider.contact_info
        )
        self.db.add(model)
        self.db.commit()
        self.db.refresh(model)
        provider.id = model.id
        return provider

    def list_by_category(self, category: str) -> List[Provider]:
        cat_enum = ServiceCategory(category)
        models = self.db.query(ProviderModel).filter(ProviderModel.category == cat_enum).all()
        return [Provider(id=m.id, name=m.name, category=m.category, contact_info=m.contact_info) for m in models]

    def get_by_id(self, provider_id: int) -> Optional[Provider]:
        model = self.db.query(ProviderModel).filter(ProviderModel.id == provider_id).first()
        if model:
            return Provider(id=model.id, name=model.name, category=model.category, contact_info=model.contact_info)
        return None

class SQLAlchemyBookingRepository(BookingRepository):
    def __init__(self, db: Session):
        self.db = db

    def save(self, booking: Booking) -> Booking:
        model = BookingModel(event_id=booking.event_id, provider_id=booking.provider_id, status=booking.status)
        self.db.add(model)
        self.db.commit()
        self.db.refresh(model)
        booking.id = model.id
        return booking

    def list_by_event(self, event_id: int) -> List[Booking]:
        models = self.db.query(BookingModel).filter(BookingModel.event_id == event_id).all()
        return [Booking(id=m.id, event_id=m.event_id, provider_id=m.provider_id, status=m.status) for m in models]
