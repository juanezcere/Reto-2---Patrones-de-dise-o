from datetime import datetime
import pytest
from src.domain.entities import Event, Artist, ServiceCategory, Provider
from src.domain.builders import EventBuilder
from src.domain.factories import ProviderFactory

def test_event_builder():
    date = datetime(2026, 12, 1)
    event = EventBuilder("Altavoz Fest", 1)\
            .at_location("Estadio Atanasio Girardot")\
            .on_date(date)\
            .build()
    
    assert event.title == "Altavoz Fest"
    assert event.location == "Estadio Atanasio Girardot"
    assert event.date == date
    assert event.artist_id == 1

def test_provider_factory_success():
    provider = ProviderFactory.create_provider("Sonido Pro", "sound", "300123")
    assert provider.name == "Sonido Pro"
    assert provider.category == ServiceCategory.SOUND

def test_provider_factory_invalid_category():
    with pytest.raises(ValueError) as excinfo:
        ProviderFactory.create_provider("Invalido", "catering", "000")
    assert "no es válida para Medellín" in str(excinfo.value)
