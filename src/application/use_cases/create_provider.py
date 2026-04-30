from src.domain.factories import ProviderFactory
from src.application.ports.repositories import ProviderRepository


class CreateProviderUseCase:
    def __init__(self, provider_repo: ProviderRepository):
        self.provider_repo = provider_repo

    def execute(self, name: str, category: str, contact_info: str):
        provider = ProviderFactory.create_provider(
            name, category, contact_info)
        return self.provider_repo.save(provider)
