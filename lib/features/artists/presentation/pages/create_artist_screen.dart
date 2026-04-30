import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/artist_notifier.dart';

class CreateArtistScreen extends StatefulWidget {
  const CreateArtistScreen({super.key});

  @override
  State<CreateArtistScreen> createState() => _CreateArtistScreenState();
}

class _CreateArtistScreenState extends State<CreateArtistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<ArtistNotifier>().addArtist(
            _nameController.text.trim(),
            _emailController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ArtistNotifier>();

    if (notifier.created || notifier.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (notifier.created) {
          notifier.resetFlags();
          context.pop();
        } else if (notifier.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${notifier.error}')),
          );
          notifier.resetFlags();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create Artist')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              if (notifier.isLoading)
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
