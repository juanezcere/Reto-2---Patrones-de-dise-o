import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../artists/domain/entities/artist.dart';
import '../../../artists/presentation/providers/artist_notifier.dart';
import '../providers/event_notifier.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  Artist? _selectedArtist;

  @override
  void initState() {
    super.initState();
    context.read<ArtistNotifier>().loadArtists();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedArtist != null) {
      context.read<EventNotifier>().addEvent(
            title: _titleController.text.trim(),
            date: _dateController.text.trim(),
            location: _locationController.text.trim(),
            artistId: _selectedArtist!.id,
          );
    } else if (_selectedArtist == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an artist')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final artistNotifier = context.watch<ArtistNotifier>();
    final eventNotifier = context.watch<EventNotifier>();

    if (eventNotifier.created || eventNotifier.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (eventNotifier.created) {
          eventNotifier.resetFlags();
          context.pop();
        } else if (eventNotifier.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${eventNotifier.error}')),
          );
          eventNotifier.resetFlags();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (artistNotifier.isLoading)
                const LinearProgressIndicator()
              else
                DropdownButtonFormField<Artist>(
                  initialValue: _selectedArtist,
                  decoration: const InputDecoration(labelText: 'Artist'),
                  items: artistNotifier.artists
                      .map((a) =>
                          DropdownMenuItem(value: a, child: Text(a.name)))
                      .toList(),
                  onChanged: (a) => setState(() => _selectedArtist = a),
                  validator: (v) => v == null ? 'Select an artist' : null,
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (ISO8601)',
                  hintText: '2024-12-31T20:00:00',
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              if (eventNotifier.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Create'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
