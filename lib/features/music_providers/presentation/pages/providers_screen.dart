import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/service_provider_notifier.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({super.key});

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context.read<ServiceProviderNotifier>().init();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ServiceProviderNotifier>();

    if (notifier.isLoading && notifier.categories.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Providers')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Providers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration:
                  const InputDecoration(labelText: 'Filter by Category'),
              items: [
                const DropdownMenuItem(
                    value: null, child: Text('All categories')),
                ...notifier.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c))),
              ],
              onChanged: (cat) {
                setState(() => _selectedCategory = cat);
                context.read<ServiceProviderNotifier>().filterByCategory(cat);
              },
            ),
          ),
          if (notifier.isLoading) const LinearProgressIndicator(),
          Expanded(
            child: notifier.error != null
                ? Center(child: Text('Error: ${notifier.error}'))
                : notifier.providers.isEmpty
                    ? const Center(child: Text('No providers found'))
                    : ListView.builder(
                        itemCount: notifier.providers.length,
                        itemBuilder: (context, index) {
                          final p = notifier.providers[index];
                          return ListTile(
                            title: Text(p.name),
                            subtitle: Text(p.category),
                            trailing: Text(p.contactInfo),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final notifier = context.read<ServiceProviderNotifier>();
          await context.push('/providers/create');
          if (mounted) notifier.filterByCategory(_selectedCategory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
