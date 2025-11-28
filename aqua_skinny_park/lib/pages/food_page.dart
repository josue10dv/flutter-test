import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  String comboType = 'a';
  String comboAmount = '';
  String resultText = '';

  void calculateSpent() {
    final quantity = double.tryParse(comboAmount.replaceAll(',', '.')) ?? 0.0;
    // Crea un mapa con los precios de tickets por tipo
    final comboPrices = {'a': 14.25, 'b': 17.9, 'c': 21.5};

    if (quantity <= 0) {
      setState(() {
        resultText = 'Ingrese una cantidad válida';
      });
      return;
    }

    final rawPrice = comboPrices[comboType] ?? 0.0;
    final total = rawPrice * quantity;

    setState(() {
      resultText =
          'Precio del combo: \$${rawPrice.toStringAsFixed(2)}\n'
          'Precio final: \$${total.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de gasto en comida'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione el tipo de combo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            DropdownButton<String>(
              value: comboType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'a', child: Text('Combo Infantil')),
                DropdownMenuItem(value: 'b', child: Text('Combo Adulto')),
                DropdownMenuItem(value: 'c', child: Text('Combo Familiar')),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  comboType = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad de combos',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                comboAmount = value;
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateSpent,
              child: const Text('Calcular'),
            ),

            const SizedBox(height: 16),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}
