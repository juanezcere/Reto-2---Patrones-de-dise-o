from src.domain.entities import Provider, ServiceCategory
from src.application.ports.repositories import ProviderRepository

class CreateProviderUseCase:
    def __init__(self, provider_repo: ProviderRepository):
        self.provider_repo = provider_repo

    def execute(self, name: str, category: str, contact_info: str) -> Provider:
        cat_enum = ServiceCategory(category)
        provider = Provider(id=None, name=name, category=cat_enum, contact_info=contact_info)
        return self.provider_repo.save(provider)
