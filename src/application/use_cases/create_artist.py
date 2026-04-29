from src.domain.entities import Artist
from src.application.ports.repositories import ArtistRepository

class CreateArtistUseCase:
    def __init__(self, artist_repo: ArtistRepository):
        self.artist_repo = artist_repo

    def execute(self, name: str, email: str) -> Artist:
        artist = Artist(id=None, name=name, email=email)
        return self.artist_repo.save(artist)
