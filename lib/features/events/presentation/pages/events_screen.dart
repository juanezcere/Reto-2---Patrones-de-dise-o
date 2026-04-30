import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../artists/domain/entities/artist.dart';
import '../../../artists/presentation/providers/artist_notifier.dart';
import '../providers/event_notifier.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Artist? _selectedArtist;

  @override
  void initState() {
    super.initState();
    context.read<ArtistNotifier>().loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    final artistNotifier = context.watch<ArtistNotifier>();
    final eventNotifier = context.watch<EventNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
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
                      setState(() => _selectedArtist = artist);
                      if (artist != null) {
                        context.read<EventNotifier>().loadEvents(artist.id);
                      }
                    },
                  ),
          ),
          Expanded(
            child: Builder(builder: (_) {
              if (_selectedArtist == null) {
                return const Center(
                    child: Text('Select an artist to see events'));
              }
              if (eventNotifier.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (eventNotifier.error != null) {
                return Center(child: Text('Error: ${eventNotifier.error}'));
              }
              if (eventNotifier.events.isEmpty) {
                return const Center(child: Text('No events found'));
              }
              return ListView.builder(
                itemCount: eventNotifier.events.length,
                itemBuilder: (context, index) {
                  final event = eventNotifier.events[index];
                  return ListTile(
                    title: Text(event.title),
                    subtitle: Text('${event.date} · ${event.location}'),
                    leading: const Icon(Icons.event),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final notifier = context.read<EventNotifier>();
          await context.push('/events/create');
          if (mounted && _selectedArtist != null) {
            notifier.loadEvents(_selectedArtist!.id);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
