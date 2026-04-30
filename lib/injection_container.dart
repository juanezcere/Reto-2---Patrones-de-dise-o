import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/constants/app_constants.dart';
import 'features/artists/data/datasources/artist_remote_datasource.dart';
import 'features/artists/data/repositories/artist_repository_impl.dart';
import 'features/artists/domain/repositories/artist_repository.dart';
import 'features/artists/domain/usecases/create_artist.dart';
import 'features/artists/domain/usecases/get_artists.dart';
import 'features/artists/presentation/providers/artist_notifier.dart';
import 'features/bookings/data/datasources/booking_remote_datasource.dart';
import 'features/bookings/data/repositories/booking_repository_impl.dart';
import 'features/bookings/domain/repositories/booking_repository.dart';
import 'features/bookings/domain/usecases/create_booking.dart';
import 'features/bookings/domain/usecases/get_event_bookings.dart';
import 'features/bookings/presentation/providers/booking_notifier.dart';
import 'features/events/data/datasources/event_remote_datasource.dart';
import 'features/events/data/repositories/event_repository_impl.dart';
import 'features/events/domain/repositories/event_repository.dart';
import 'features/events/domain/usecases/create_event.dart';
import 'features/events/domain/usecases/get_artist_events.dart';
import 'features/events/presentation/providers/event_notifier.dart';
import 'features/providers/data/datasources/provider_remote_datasource.dart';
import 'features/providers/data/repositories/provider_repository_impl.dart';
import 'features/providers/domain/repositories/provider_repository.dart';
import 'features/providers/domain/usecases/create_provider.dart';
import 'features/providers/domain/usecases/get_categories.dart';
import 'features/providers/domain/usecases/get_providers.dart';
import 'features/providers/presentation/providers/service_provider_notifier.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ─── External ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      )));

  // ─── Data sources ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<ArtistRemoteDataSource>(
      () => ArtistRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<ProviderRemoteDataSource>(
      () => ProviderRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<BookingRemoteDataSource>(
      () => BookingRemoteDataSourceImpl(dio: sl()));

  // ─── Repositories ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<ArtistRepository>(
      () => ArtistRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ProviderRepository>(
      () => ProviderRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<BookingRepository>(
      () => BookingRepositoryImpl(remoteDataSource: sl()));

  // ─── Use cases ────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetArtistsUseCase(sl()));
  sl.registerLazySingleton(() => CreateArtistUseCase(sl()));
  sl.registerLazySingleton(() => GetArtistEventsUseCase(sl()));
  sl.registerLazySingleton(() => CreateEventUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetProvidersUseCase(sl()));
  sl.registerLazySingleton(() => CreateProviderUseCase(sl()));
  sl.registerLazySingleton(() => GetEventBookingsUseCase(sl()));
  sl.registerLazySingleton(() => CreateBookingUseCase(sl()));

  // ─── Notifiers (factory — new instance per screen) ────────────────────────
  sl.registerFactory(() => ArtistNotifier(
        getArtists: sl(),
        createArtist: sl(),
      ));
  sl.registerFactory(() => EventNotifier(
        getArtistEvents: sl(),
        createEvent: sl(),
      ));
  sl.registerFactory(() => ServiceProviderNotifier(
        getCategories: sl(),
        getProviders: sl(),
        createProvider: sl(),
      ));
  sl.registerFactory(() => BookingNotifier(
        getEventBookings: sl(),
        createBooking: sl(),
      ));
}
