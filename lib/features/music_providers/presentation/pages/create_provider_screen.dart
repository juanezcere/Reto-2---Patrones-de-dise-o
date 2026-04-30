import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/service_provider_notifier.dart';

class CreateProviderScreen extends StatefulWidget {
  const CreateProviderScreen({super.key});

  @override
  State<CreateProviderScreen> createState() => _CreateProviderScreenState();
}

class _CreateProviderScreenState extends State<CreateProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<ServiceProviderNotifier>().loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      context.read<ServiceProviderNotifier>().addProvider(
            name: _nameController.text.trim(),
            category: _selectedCategory!,
            contactInfo: _contactController.text.trim(),
          );
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ServiceProviderNotifier>();

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
      appBar: AppBar(title: const Text('Create Provider')),
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
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: notifier.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (c) => setState(() => _selectedCategory = c),
                validator: (v) => v == null ? 'Select a category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactController,
                decoration:
                    const InputDecoration(labelText: 'Contact Info'),
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
