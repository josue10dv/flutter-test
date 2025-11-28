import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpentPage extends StatefulWidget {
  const SpentPage({super.key});

  @override
  State<SpentPage> createState() => _SpentPageState();
}

class _SpentPageState extends State<SpentPage> {
  String nameText = '';
  String prizeText = '';
  String quantityText = '';

  final List<TextEditingController> nameController = [];
  final List<TextEditingController> prizeController = [];
  final List<TextEditingController> quantityController = [];
  final List<TextEditingController> totalController = [];

  String resultText = '';

  void _generateProductItem() {
    setState(() {
      resultText = '';
    });

    final parsedName = nameText.trim();
    if (parsedName.isEmpty) {
      setState(() {
        resultText = 'Ingrese un nombre válido para el producto.';
      });
      return;
    }
    final parsedPrize = double.tryParse(prizeText.replaceAll(',', '.')) ?? 0.0;
    if (parsedPrize <= 0) {
      setState(() {
        resultText = 'Ingrese un precio válido para el producto.';
      });
      return;
    }
    final parsedQuantity =
        double.tryParse(quantityText.replaceAll(',', '.')) ?? 0.0;
    if (parsedQuantity <= 0) {
      setState(() {
        resultText = 'Ingrese una cantidad válida para el producto.';
      });
      return;
    }
    final total = parsedPrize * parsedQuantity;

    nameController.add(TextEditingController(text: parsedName));
    prizeController.add(
      TextEditingController(text: parsedPrize.toStringAsFixed(2)),
    );
    quantityController.add(
      TextEditingController(text: parsedQuantity.toStringAsFixed(2)),
    );
    totalController.add(TextEditingController(text: total.toStringAsFixed(2)));
    // Limpieza
    nameText = '';
    prizeText = '';
    quantityText = '';

    setState(() {
      resultText =
          'Subtotal agregado para $parsedName: \$${total.toStringAsFixed(2)}';
    });
  }

  void _calculateProductTotals() {
    if (nameController.isEmpty) {
      setState(() {
        resultText =
            'Primero agregue productos para calcular el total gastado.';
      });
      return;
    }
    double totalSpent = 0.0;
    double totalItems = 0.0;

    for (int i = 0; i < nameController.length; i++) {
      final prize = double.tryParse(prizeController[i].text) ?? 0.0;
      final quantity = double.tryParse(quantityController[i].text) ?? 0.0;
      totalSpent += prize * quantity;
      totalItems += quantity;
    }

    setState(() {
      resultText =
          'El total gastado en productos es: \$${totalSpent.toStringAsFixed(2)}\n'
          'El total de artículos comprados es: ${totalItems.toStringAsFixed(2)}';
    });
  }

  @override
  void dispose() {
    for (final c in nameController) {
      c.dispose();
    }
    for (final c in prizeController) {
      c.dispose();
    }
    for (final c in quantityController) {
      c.dispose();
    }
    for (final c in totalController) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculador de gasto en productos'),
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
                'Ingrese información del producto:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  nameText = value;
                },
              ),
              const SizedBox(height: 12),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Precio del producto',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  prizeText = value;
                },
              ),
              const SizedBox(height: 12),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Cantidad del producto',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  quantityText = value;
                },
              ),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _generateProductItem,
                child: const Text('Agregar Item'),
              ),

              const SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: nameController.length,
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
                              controller: nameController[index],
                              decoration: InputDecoration(
                                labelText: 'Producto ${index + 1}',
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: prizeController[index],
                              decoration: const InputDecoration(
                                labelText: 'Precio',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: quantityController[index],
                              decoration: const InputDecoration(
                                labelText: 'Cant',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: totalController[index],
                              decoration: const InputDecoration(
                                labelText: 'Total',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: _calculateProductTotals,
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
