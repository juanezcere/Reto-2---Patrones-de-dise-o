import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event & Booking Manager')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/artists'),
              child: const Text('Artists'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/events'),
              child: const Text('Events'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/providers'),
              child: const Text('Providers'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/bookings'),
              child: const Text('Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}
