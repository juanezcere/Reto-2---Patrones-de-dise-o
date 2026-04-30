import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Event & Booking Manager',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
