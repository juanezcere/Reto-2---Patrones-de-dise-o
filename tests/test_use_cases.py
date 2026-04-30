import pytest
from unittest.mock import MagicMock
from datetime import datetime
from src.application.use_cases.create_artist import CreateArtistUseCase
from src.application.use_cases.create_event import CreateEventUseCase
from src.application.use_cases.book_resource import BookResourceUseCase
from src.domain.entities import Artist, Event, Provider, ServiceCategory, Booking

def test_create_artist_use_case():
    mock_repo = MagicMock()
    use_case = CreateArtistUseCase(mock_repo)
    
    use_case.execute("Juanes", "juanes@example.com")
    
    # Verificamos que se llamó al repo con un objeto Artist
    mock_repo.save.assert_called_once()
    saved_artist = mock_repo.save.call_args[0][0]
    assert saved_artist.name == "Juanes"

def test_create_event_use_case():
    mock_repo = MagicMock()
    use_case = CreateEventUseCase(mock_repo)
    
    use_case.execute("Concierto", datetime.now(), "Plaza Botero", 1)
    
    mock_repo.save.assert_called_once()
    saved_event = mock_repo.save.call_args[0][0]
    assert saved_event.title == "Concierto"
    assert saved_event.artist_id == 1

def test_book_resource_success():
    # Mocks de repositorios
    mock_booking_repo = MagicMock()
    mock_provider_repo = MagicMock()
    mock_event_repo = MagicMock()
    
    # Configuramos respuestas de los mocks
    mock_event_repo.get_by_id.return_value = Event(1, "E", datetime.now(), "L", 1)
    mock_provider_repo.get_by_id.return_value = Provider(1, "P", ServiceCategory.SOUND, "C")
    
    use_case = BookResourceUseCase(mock_booking_repo, mock_provider_repo, mock_event_repo)
    use_case.execute(event_id=1, provider_id=1)
    
    mock_booking_repo.save.assert_called_once()

def test_book_resource_event_not_found():
    mock_event_repo = MagicMock()
    mock_event_repo.get_by_id.return_value = None
    
    use_case = BookResourceUseCase(MagicMock(), MagicMock(), mock_event_repo)
    
    with pytest.raises(ValueError, match="Event not found"):
        use_case.execute(1, 1)
