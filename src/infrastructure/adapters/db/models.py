from sqlalchemy import Column, Integer, String, DateTime, ForeignKey, Enum as SQLEnum
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from src.domain.entities import ServiceCategory

Base = declarative_base()

class ArtistModel(Base):
    __tablename__ = "artists"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    email = Column(String, unique=True)

class ProviderModel(Base):
    __tablename__ = "providers"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    category = Column(SQLEnum(ServiceCategory))
    contact_info = Column(String)

class EventModel(Base):
    __tablename__ = "events"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    date = Column(DateTime)
    location = Column(String)
    artist_id = Column(Integer, ForeignKey("artists.id"))

class BookingModel(Base):
    __tablename__ = "bookings"
    id = Column(Integer, primary_key=True, index=True)
    event_id = Column(Integer, ForeignKey("events.id"))
    provider_id = Column(Integer, ForeignKey("providers.id"))
    status = Column(String, default="pending")
