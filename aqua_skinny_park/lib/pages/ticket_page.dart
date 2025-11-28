import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  String discountType = 'Día regular';
  String adultsAmount = '';
  String childrenAmount = '';
  String resultText = '';

  void calculateTicket() {
    final adults = double.tryParse(adultsAmount.replaceAll(',', '.')) ?? 0.0;
    final children =
        double.tryParse(childrenAmount.replaceAll(',', '.')) ?? 0.0;
    double discount = 0.0;
    // Crea un mapa con los precios de tickets por tipo
    final ticketPrices = {'a': 20.0, 'n': 10.0};

    if (adults <= 0 && children <= 0) {
      setState(() {
        resultText = 'Ingrese la cantidad de adultos y niños válidos';
      });
      return;
    }
    // Calcula el descuento según el tipo seleccionado
    if (discountType == 'Día feriado') {
      discount = 0.10;
    } else if (discountType == 'Fin de semana') {
      discount = 0.05;
    }

    final pricePerAdult = (ticketPrices['a'] ?? 0.0) * adults;
    final pricePerChild = (ticketPrices['n'] ?? 0.0) * children;
    final rawTotal = pricePerAdult + pricePerChild;
    final totalPrice = rawTotal - (rawTotal * discount);

    setState(() {
      resultText =
          'Cantidad de adultos: ${adults.toStringAsFixed(0)}\n'
          'Cantidad de niños: ${children.toStringAsFixed(0)}\n'
          'Precio tickets: \$${rawTotal.toStringAsFixed(2)}\n'
          'Descuento aplicado: ${(discount * 100).toStringAsFixed(2)}%\n'
          'Precio final: \$${totalPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de tickets con descuentos'),
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
              'Seleccione el tipo de día:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            DropdownButton<String>(
              value: discountType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Día regular',
                  child: Text('Día regular'),
                ),
                DropdownMenuItem(
                  value: 'Día feriado',
                  child: Text('Día feriado'),
                ),
                DropdownMenuItem(
                  value: 'Fin de semana',
                  child: Text('Fin de semana'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  discountType = value;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad de adultos',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                adultsAmount = value;
              },
            ),

            const SizedBox(height: 16),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad de niños',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                childrenAmount = value;
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateTicket,
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
