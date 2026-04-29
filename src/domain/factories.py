from src.domain.entities import Provider, ServiceCategory, SoundProvider, TransportProvider, StaffProvider, EquipmentProvider


class ProviderFactory:
    @staticmethod
    def create_provider(name: str, category_name: str, contact_info: str) -> Provider:
        try:
            category = ServiceCategory(category_name)
        except ValueError:
            raise ValueError(
                f"Categoría '{category_name}' no es válida para Medellín.")
        if category == ServiceCategory.SOUND:
            return SoundProviderFactory.create_provider(name, contact_info, 0)
        elif category == ServiceCategory.TRANSPORT:
            return TransportProviderFactory.create_provider(name, contact_info, 0, 0)
        elif category == ServiceCategory.STAFF:
            return StaffProviderFactory.create_provider(name, contact_info, 0, "")
        elif category == ServiceCategory.EQUIPMENT:
            return EquipmentProviderFactory.create_provider(name, contact_info, 0)
        else:
            return Provider(
                id=None,
                name=name,
                category=category,
                contact_info=contact_info
            )


class SoundProviderFactory:
    @staticmethod
    def create_provider(name: str, contact_info: str, sound_power: int) -> SoundProvider:
        return SoundProvider(
            id=None,
            name=name,
            category=ServiceCategory.SOUND,
            contact_info=contact_info,
            sound_power=sound_power
        )


class TransportProviderFactory:
    @staticmethod
    def create_provider(name: str, contact_info: str, vehicle_quantity: int, vehicle_capacity: int) -> TransportProvider:
        return TransportProvider(
            id=None,
            name=name,
            category=ServiceCategory.TRANSPORT,
            contact_info=contact_info,
            vehicle_quantity=vehicle_quantity,
            vehicle_capacity=vehicle_capacity
        )


class StaffProviderFactory:
    @staticmethod
    def create_provider(name: str, contact_info: str, staff_quantity: int, staff_coordinator: str) -> StaffProvider:
        return StaffProvider(
            id=None,
            name=name,
            category=ServiceCategory.STAFF,
            contact_info=contact_info,
            staff_quantity=staff_quantity,
            staff_coordinator=staff_coordinator
        )


class EquipmentProviderFactory:
    @staticmethod
    def create_provider(name: str, contact_info: str, equipment_type: int) -> EquipmentProvider:
        return EquipmentProvider(
            id=None,
            name=name,
            category=ServiceCategory.EQUIPMENT,
            contact_info=contact_info,
            equipment_type=equipment_type
        )
