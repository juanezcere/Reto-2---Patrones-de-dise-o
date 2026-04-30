# Event & Booking Manager — Flutter MVP

Aplicación móvil para gestión de artistas, eventos, proveedores y reservas, construida en Flutter consumiendo una API REST.

---

## Arquitectura: Clean Architecture

El proyecto está organizado en **3 capas por módulo**, siguiendo los principios de Clean Architecture de Robert C. Martin:

```
lib/
├── core/                        # Utilidades compartidas (errores, router, constantes)
└── features/
    ├── artists/
    │   ├── domain/              # Capa de dominio (pura, sin dependencias externas)
    │   │   ├── entities/        # Modelos de negocio
    │   │   ├── repositories/    # Contratos abstractos
    │   │   └── usecases/        # Casos de uso
    │   ├── data/                # Capa de datos
    │   │   ├── datasources/     # Fuentes de datos remotas (API)
    │   │   ├── models/          # Modelos con serialización JSON
    │   │   └── repositories/    # Implementaciones de los contratos
    │   └── presentation/        # Capa de presentación
    │       ├── providers/       # Estado (ChangeNotifier)
    │       └── pages/           # Pantallas
    ├── events/
    ├── bookings/
    └── music_providers/
```

**Principio de dependencia:** las capas internas (domain) no conocen las externas (data, presentation). La comunicación hacia adentro se hace mediante interfaces (repositorios abstractos).

---

## Patrones de diseño aplicados

### Creacionales

#### Singleton
Aplicado a través de **get_it** con `registerLazySingleton`. Las dependencias como `Dio`, repositorios y casos de uso se instancian una sola vez y se reutilizan durante toda la vida de la app.

```dart
sl.registerLazySingleton<ArtistRepository>(
  () => ArtistRepositoryImpl(remoteDataSource: sl()),
);
```

#### Factory
Aplicado a través de **get_it** con `registerFactory`. Los `ChangeNotifier` (providers de estado) se crean como instancias nuevas por cada pantalla, evitando que el estado se comparta entre rutas.

```dart
sl.registerFactory(() => ArtistNotifier(
  getArtists: sl(),
  createArtist: sl(),
));
```

---

### Estructurales

#### Repository
Cada módulo define un contrato abstracto en la capa de dominio y su implementación concreta en la capa de datos. La presentación solo conoce la abstracción, nunca la implementación.

```dart
// Dominio — contrato
abstract class ArtistRepository {
  Future<Either<Failure, List<Artist>>> getArtists();
}

// Datos — implementación
class ArtistRepositoryImpl implements ArtistRepository { ... }
```

#### Dependency Injection (Service Locator)
**get_it** actúa como contenedor de inyección de dependencias. Todas las dependencias se registran en `injection_container.dart` y se resuelven automáticamente en el grafo de objetos.

---

### De comportamiento

#### Observer
Los `ChangeNotifier` implementan el patrón Observer. Las pantallas se suscriben al estado usando `context.watch<T>()` y se reconstruyen automáticamente cuando el notifier llama a `notifyListeners()`.

```dart
class ArtistNotifier extends ChangeNotifier {
  List<Artist> artists = [];

  Future<void> loadArtists() async {
    // ...
    notifyListeners(); // notifica a todos los observadores
  }
}
```

#### Use Case / Command
Cada operación de negocio está encapsulada en su propio caso de uso. Esto desacopla la lógica de negocio de la fuente de datos y de la UI.

```dart
class GetArtistsUseCase {
  final ArtistRepository repository;
  GetArtistsUseCase(this.repository);

  Future<Either<Failure, List<Artist>>> call() => repository.getArtists();
}
```

---

## Manejo de errores: Either (Railway-Oriented Programming)

Usando la librería **dartz**, todos los repositorios y casos de uso retornan `Either<Failure, T>` en lugar de lanzar excepciones. Esto hace el flujo de error explícito y manejable.

```dart
// Right = éxito, Left = fallo
(await _getArtists()).fold(
  (failure) => error = failure.message,  // Left
  (data)    => artists = data,           // Right
);
```

---

## Stack tecnológico

| Librería | Uso |
|---|---|
| `dio` | Cliente HTTP para consumo de la API REST |
| `provider` | Manejo de estado reactivo (ChangeNotifier) |
| `get_it` | Inyección de dependencias (Service Locator) |
| `go_router` | Navegación declarativa |
| `dartz` | Tipos funcionales (`Either`) para manejo de errores |
| `equatable` | Comparación por valor en entidades de dominio |

---

## Pantallas

| Ruta | Pantalla |
|---|---|
| `/` | Home |
| `/artists` | Lista de artistas |
| `/artists/create` | Crear artista |
| `/events` | Eventos por artista |
| `/events/create` | Crear evento |
| `/providers` | Proveedores filtrados por categoría |
| `/providers/create` | Crear proveedor |
| `/bookings` | Reservas por evento |
| `/bookings/create` | Crear reserva |
