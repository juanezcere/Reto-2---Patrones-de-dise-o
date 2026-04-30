import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/artist_notifier.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ArtistNotifier>().loadArtists();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ArtistNotifier>();
    return Scaffold(
      appBar: AppBar(title: const Text('Artists')),
      body: Builder(builder: (_) {
        if (notifier.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (notifier.error != null) {
          return Center(child: Text('Error: ${notifier.error}'));
        }
        if (notifier.artists.isEmpty) {
          return const Center(child: Text('No artists found'));
        }
        return ListView.builder(
          itemCount: notifier.artists.length,
          itemBuilder: (context, index) {
            final artist = notifier.artists[index];
            return ListTile(
              title: Text(artist.name),
              subtitle: Text(artist.email),
              leading: const Icon(Icons.person),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final notifier = context.read<ArtistNotifier>();
          await context.push('/artists/create');
          if (mounted) notifier.loadArtists();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
