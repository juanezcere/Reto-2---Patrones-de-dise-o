from src.domain.exceptions import EmailExistsError
from src.domain.entities import Artist
from src.domain.decorators import email_validator, send_verification_email
from src.application.ports.repositories import ArtistRepository


class CreateArtistUseCase:
    def __init__(self, artist_repo: ArtistRepository):
        self.artist_repo = artist_repo

    @email_validator
    @send_verification_email
    def execute(self, name: str, email: str) -> Artist:
        artist = Artist(id=None, name=name, email=email)
        try:
            return self.artist_repo.save(artist)
        except Exception as e:
            print("Exception creating artist:", e)
            raise EmailExistsError()
