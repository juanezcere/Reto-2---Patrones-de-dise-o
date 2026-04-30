import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../features/artists/presentation/providers/artist_notifier.dart';
import '../../features/artists/presentation/pages/artists_screen.dart';
import '../../features/artists/presentation/pages/create_artist_screen.dart';
import '../../features/bookings/presentation/providers/booking_notifier.dart';
import '../../features/bookings/presentation/pages/bookings_screen.dart';
import '../../features/bookings/presentation/pages/create_booking_screen.dart';
import '../../features/events/presentation/providers/event_notifier.dart';
import '../../features/events/presentation/pages/create_event_screen.dart';
import '../../features/events/presentation/pages/events_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/providers/presentation/providers/service_provider_notifier.dart';
import '../../features/providers/presentation/pages/create_provider_screen.dart';
import '../../features/providers/presentation/pages/providers_screen.dart';
import '../../injection_container.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _) => const HomeScreen(),
    ),
    GoRoute(
      path: '/artists',
      builder: (_, _) => ChangeNotifierProvider(
        create: (_) => sl<ArtistNotifier>(),
        child: const ArtistsScreen(),
      ),
    ),
    GoRoute(
      path: '/artists/create',
      builder: (_, _) => ChangeNotifierProvider(
        create: (_) => sl<ArtistNotifier>(),
        child: const CreateArtistScreen(),
      ),
    ),
    GoRoute(
      path: '/events',
      builder: (_, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<ArtistNotifier>()),
          ChangeNotifierProvider(create: (_) => sl<EventNotifier>()),
        ],
        child: const EventsScreen(),
      ),
    ),
    GoRoute(
      path: '/events/create',
      builder: (_, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<ArtistNotifier>()),
          ChangeNotifierProvider(create: (_) => sl<EventNotifier>()),
        ],
        child: const CreateEventScreen(),
      ),
    ),
    GoRoute(
      path: '/providers',
      builder: (_, _) => ChangeNotifierProvider(
        create: (_) => sl<ServiceProviderNotifier>(),
        child: const ProvidersScreen(),
      ),
    ),
    GoRoute(
      path: '/providers/create',
      builder: (_, _) => ChangeNotifierProvider(
        create: (_) => sl<ServiceProviderNotifier>(),
        child: const CreateProviderScreen(),
      ),
    ),
    GoRoute(
      path: '/bookings',
      builder: (_, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<ArtistNotifier>()),
          ChangeNotifierProvider(create: (_) => sl<EventNotifier>()),
          ChangeNotifierProvider(create: (_) => sl<BookingNotifier>()),
        ],
        child: const BookingsScreen(),
      ),
    ),
    GoRoute(
      path: '/bookings/create',
      builder: (_, _) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => sl<ServiceProviderNotifier>()),
          ChangeNotifierProvider(create: (_) => sl<BookingNotifier>()),
        ],
        child: const CreateBookingScreen(),
      ),
    ),
  ],
);
