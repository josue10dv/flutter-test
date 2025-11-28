import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlidePage extends StatefulWidget {
  const SlidePage({super.key});

  @override
  State<SlidePage> createState() => _SlidePageState();
}

class _SlidePageState extends State<SlidePage> {
  String slidesCountText = '';
  int slidesCount = 0;

  final List<TextEditingController> slideNameController = [];
  final List<TextEditingController> rideAmuntController = [];

  String resultText = '';

  void _generateSlideRides() {
    final parsed = int.tryParse(slidesCountText) ?? 0;

    if (parsed <= 0) {
      setState(() {
        resultText = 'Ingrese una cantidad de válida';
        slidesCount = 0;
        slideNameController.clear();
        rideAmuntController.clear();
      });
      return;
    }

    slidesCount = parsed;
    slideNameController.clear();
    rideAmuntController.clear();

    for (int i = 0; i < slidesCount; i++) {
      slideNameController.add(TextEditingController());
      rideAmuntController.add(TextEditingController());
    }

    setState(() {
      resultText = 'Ingrese nombre y cantidad de vueltas para los toboganes.';
    });
  }

  void _calculateAvarage() {
    if (slidesCount == 0) {
      setState(() {
        resultText =
            'Primero indique cuántas toboganes y cuantas vueltas desea registrar.';
      });
      return;
    }
    int ridesAmount = 0;
    final List<String> lines = [];
    var avaragePerTobogan = {};

    for (int i = 0; i < slidesCount; i++) {
      final name = slideNameController[i].text.trim().isEmpty
          ? 'Tobogan ${i + 1}'
          : slideNameController[i].text.trim();
      final rides = int.tryParse(rideAmuntController[i].text.trim()) ?? 0;
      if (avaragePerTobogan.containsKey(name)) {
        avaragePerTobogan[name] = {
          'total': avaragePerTobogan[name]['total'] + rides,
          'count': avaragePerTobogan[name]['count'] + 1,
        };
      } else {
        avaragePerTobogan[name] = {'total': rides, 'count': 1};
      }
      lines.add('- $name: ${avaragePerTobogan[name]['total']} vueltas');
      ridesAmount += rides;
    }
    final List<String> avarages = [];
    // Obtiene el promedio de vueltas por tobogan
    for (final entry in avaragePerTobogan.entries) {
      final avg = entry.value['total'] / entry.value['count'];
      avarages.add(
        '  Promedio de ${entry.key}: ${avg.toStringAsFixed(2)} vueltas',
      );
    }

    setState(() {
      resultText =
          'Vueltas totales en todos los toboganes: $ridesAmount\n'
          '${lines.join('\n')}\n\n'
          'Promedio de vueltas por tobogan\n\n'
          '${avarages.join('\n')}\n\n';
    });
  }

  @override
  void dispose() {
    for (final c in slideNameController) {
      c.dispose();
    }
    for (final c in rideAmuntController) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio de vueltas en toboganes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Calculadora de vueltas en toboganes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Cantidad de toboganes',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  slidesCountText = value;
                },
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _generateSlideRides,
                child: const Text('Generar campos'),
              ),

              const SizedBox(height: 16),

              if (slidesCount > 0)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: slidesCount,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: slideNameController[index],
                                decoration: InputDecoration(
                                  labelText: 'Tobogan ${index + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: rideAmuntController[index],
                                decoration: const InputDecoration(
                                  labelText: 'Vueltas',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 16),
              if (slidesCount > 0)
                ElevatedButton(
                  onPressed: _calculateAvarage,
                  child: const Text('Calcular'),
                ),

              const SizedBox(height: 16),
              Text(resultText),
            ],
          ),
        ),
      ),
    );
  }
}
