from src.domain.entities import Booking
from src.application.ports.repositories import BookingRepository, ProviderRepository, EventRepository

class BookResourceUseCase:
    def __init__(self, booking_repo: BookingRepository, provider_repo: ProviderRepository, event_repo: EventRepository):
        self.booking_repo = booking_repo
        self.provider_repo = provider_repo
        self.event_repo = event_repo

    def execute(self, event_id: int, provider_id: int) -> Booking:
        # Business rules could go here (e.g., check if provider exists, if event belongs to artist)
        event = self.event_repo.get_by_id(event_id)
        if not event:
            raise ValueError("Event not found")
            
        provider = self.provider_repo.get_by_id(provider_id)
        if not provider:
            raise ValueError("Provider not found")

        booking = Booking(id=None, event_id=event_id, provider_id=provider_id)
        return self.booking_repo.save(booking)
