from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from datetime import datetime
from pydantic import BaseModel
from typing import List
from src.infrastructure.config import get_db
from src.infrastructure.adapters.db.sqlalchemy_repository import SQLAlchemyEventRepository, SQLAlchemyBookingRepository, SQLAlchemyProviderRepository, SQLAlchemyArtistRepository
from src.application.use_cases.create_event import CreateEventUseCase
from src.application.use_cases.book_resource import BookResourceUseCase
from src.application.use_cases.queries import ListArtistEventsUseCase, ListEventBookingsUseCase, ListArtistsUseCase
from src.application.use_cases.create_artist import CreateArtistUseCase
from src.application.use_cases.create_provider import CreateProviderUseCase

from src.domain.entities import ServiceCategory

router = APIRouter()

@router.get("/categories")
def list_categories():
    return [c.value for c in ServiceCategory]

# Schemas
class ArtistCreateRequest(BaseModel):
    name: str
    email: str

class ProviderCreateRequest(BaseModel):
    name: str
    category: str # sound, transport, equipment, staff
    contact_info: str

class EventCreateRequest(BaseModel):
    title: str
    date: datetime
    location: str
    artist_id: int

class BookingCreateRequest(BaseModel):
    event_id: int
    provider_id: int

# Artistas
@router.post("/artists")
def create_artist(req: ArtistCreateRequest, db: Session = Depends(get_db)):
    repo = SQLAlchemyArtistRepository(db)
    use_case = CreateArtistUseCase(repo)
    return use_case.execute(req.name, req.email)

@router.get("/artists")
def list_artists(db: Session = Depends(get_db)):
    repo = SQLAlchemyArtistRepository(db)
    use_case = ListArtistsUseCase(repo)
    return use_case.execute()

# Eventos
@router.post("/events")
def create_event(req: EventCreateRequest, db: Session = Depends(get_db)):
    repo = SQLAlchemyEventRepository(db)
    use_case = CreateEventUseCase(repo)
    return use_case.execute(req.title, req.date, req.location, req.artist_id)

@router.get("/artists/{artist_id}/events")
def list_artist_events(artist_id: int, db: Session = Depends(get_db)):
    repo = SQLAlchemyEventRepository(db)
    use_case = ListArtistEventsUseCase(repo)
    return use_case.execute(artist_id)

# Agendamientos/Bookings
@router.post("/bookings")
def book_resource(req: BookingCreateRequest, db: Session = Depends(get_db)):
    event_repo = SQLAlchemyEventRepository(db)
    booking_repo = SQLAlchemyBookingRepository(db)
    provider_repo = SQLAlchemyProviderRepository(db)
    use_case = BookResourceUseCase(booking_repo, provider_repo, event_repo)
    try:
        return use_case.execute(req.event_id, req.provider_id)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/events/{event_id}/bookings")
def list_event_bookings(event_id: int, db: Session = Depends(get_db)):
    repo = SQLAlchemyBookingRepository(db)
    use_case = ListEventBookingsUseCase(repo)
    return use_case.execute(event_id)

@router.get("/providers")
def list_providers(category: str = None, db: Session = Depends(get_db)):
    repo = SQLAlchemyProviderRepository(db)
    if category:
        return repo.list_by_category(category)
    return []

@router.post("/providers")
def create_provider(req: ProviderCreateRequest, db: Session = Depends(get_db)):
    repo = SQLAlchemyProviderRepository(db)
    use_case = CreateProviderUseCase(repo)
    return use_case.execute(req.name, req.category, req.contact_info)
