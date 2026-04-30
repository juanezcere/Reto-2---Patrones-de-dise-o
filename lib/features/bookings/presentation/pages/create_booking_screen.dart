import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../providers/domain/entities/provider_entity.dart';
import '../../../providers/presentation/providers/service_provider_notifier.dart';
import '../providers/booking_notifier.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _eventIdController = TextEditingController();
  ProviderEntity? _selectedProvider;

  @override
  void initState() {
    super.initState();
    context.read<ServiceProviderNotifier>().init();
  }

  @override
  void dispose() {
    _eventIdController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedProvider != null) {
      context.read<BookingNotifier>().addBooking(
            eventId: int.parse(_eventIdController.text.trim()),
            providerId: _selectedProvider!.id,
          );
    } else if (_selectedProvider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a provider')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spNotifier = context.watch<ServiceProviderNotifier>();
    final bookingNotifier = context.watch<BookingNotifier>();

    if (bookingNotifier.created || bookingNotifier.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (bookingNotifier.created) {
          bookingNotifier.resetFlags();
          context.pop();
        } else if (bookingNotifier.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${bookingNotifier.error}')),
          );
          bookingNotifier.resetFlags();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _eventIdController,
                decoration: const InputDecoration(labelText: 'Event ID'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  if (int.tryParse(v) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ProviderEntity>(
                initialValue: _selectedProvider,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: spNotifier.providers
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text('${p.name} (${p.category})'),
                        ))
                    .toList(),
                onChanged: (p) => setState(() => _selectedProvider = p),
                validator: (v) => v == null ? 'Select a provider' : null,
              ),
              const SizedBox(height: 24),
              if (bookingNotifier.isLoading)
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
