import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../artists/domain/entities/artist.dart';
import '../../../artists/presentation/providers/artist_notifier.dart';
import '../../../events/domain/entities/event.dart';
import '../../../events/presentation/providers/event_notifier.dart';
import '../providers/booking_notifier.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  Artist? _selectedArtist;
  Event? _selectedEvent;
  Key _eventDropdownKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    context.read<ArtistNotifier>().loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    final artistNotifier = context.watch<ArtistNotifier>();
    final eventNotifier = context.watch<EventNotifier>();
    final bookingNotifier = context.watch<BookingNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: artistNotifier.isLoading
                ? const LinearProgressIndicator()
                : DropdownButtonFormField<Artist>(
                    initialValue: _selectedArtist,
                    decoration:
                        const InputDecoration(labelText: 'Select Artist'),
                    items: artistNotifier.artists
                        .map((a) =>
                            DropdownMenuItem(value: a, child: Text(a.name)))
                        .toList(),
                    onChanged: (artist) {
                      setState(() {
                        _selectedArtist = artist;
                        _selectedEvent = null;
                        _eventDropdownKey = UniqueKey();
                      });
                      if (artist != null) {
                        context.read<EventNotifier>().loadEvents(artist.id);
                      }
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Builder(builder: (_) {
              if (_selectedArtist == null) return const SizedBox();
              if (eventNotifier.isLoading) {
                return const LinearProgressIndicator();
              }
              if (eventNotifier.events.isEmpty) return const SizedBox();
              return DropdownButtonFormField<Event>(
                key: _eventDropdownKey,
                initialValue: _selectedEvent,
                decoration: const InputDecoration(labelText: 'Select Event'),
                items: eventNotifier.events
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.title)))
                    .toList(),
                onChanged: (event) {
                  setState(() => _selectedEvent = event);
                  if (event != null) {
                    context.read<BookingNotifier>().loadBookings(event.id);
                  }
                },
              );
            }),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Builder(builder: (_) {
              if (_selectedEvent == null) {
                return const Center(
                    child: Text('Select an event to see bookings'));
              }
              if (bookingNotifier.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (bookingNotifier.error != null) {
                return Center(
                    child: Text('Error: ${bookingNotifier.error}'));
              }
              if (bookingNotifier.bookings.isEmpty) {
                return const Center(child: Text('No bookings found'));
              }
              return ListView.builder(
                itemCount: bookingNotifier.bookings.length,
                itemBuilder: (context, index) {
                  final b = bookingNotifier.bookings[index];
                  return ListTile(
                    title: Text('Booking #${b.id}'),
                    subtitle: Text(
                        'Event: ${b.eventId}  ·  Provider: ${b.providerId}'),
                    leading: const Icon(Icons.book_online),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final notifier = context.read<BookingNotifier>();
          await context.push('/bookings/create');
          if (mounted && _selectedEvent != null) {
            notifier.loadBookings(_selectedEvent!.id);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
