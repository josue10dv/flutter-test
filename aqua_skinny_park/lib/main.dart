import 'package:flutter/material.dart';
import 'app_router.dart';

void main() {
  runApp(const AquaParkApp());
}

class AquaParkApp extends StatelessWidget {
  const AquaParkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aqua park - GoRouter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
