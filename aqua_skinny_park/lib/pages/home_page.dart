import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Aqua Skinny Park')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione una opción:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => context.go('/ticket'),
              child: const Text('Boletos y descuentos'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/food'),
              child: const Text('Gasto en comida'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () => context.go('/slide'),
              child: const Text('Plan de toboganes'),
            ),
          ],
        ),
      ),
    );
  }
}
