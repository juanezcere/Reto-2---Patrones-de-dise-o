from datetime import datetime
from src.domain.entities import Event, Artist, ServiceCategory, Provider

def test_event_creation():
    event = Event(id=1, title="Concierto Rock", date=datetime.now(), location="Parque de los Deseos", artist_id=1)
    assert event.title == "Concierto Rock"
    assert event.artist_id == 1

def test_provider_creation():
    provider = Provider(id=1, name="Sonido Medellin", category=ServiceCategory.SOUND, contact_info="3001234567")
    assert provider.category == ServiceCategory.SOUND
