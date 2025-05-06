import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';

class ProductDetailsWidget extends StatelessWidget {
  final Product product;

  const ProductDetailsWidget({super.key, required this.product});

  bool _isValidNetworkUrl(String? url) {
    return url != null &&
        (url.startsWith('http://') || url.startsWith('https://'));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        product.name.isNotEmpty ? product.name : 'Producto sin nombre',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_isValidNetworkUrl(product.photoUrl))
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.photoUrl!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 150);
                  },
                ),
              )
            else
              const Icon(Icons.fastfood, size: 150),
            const SizedBox(height: 16),
            Text(
              'Categoría: ${product.category.isNotEmpty ? product.category : 'Sin categoría'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Cantidad total: ${product.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            if (product.notes != null && product.notes!.isNotEmpty)
              Text(
                'Notas: ${product.notes}',
                style: const TextStyle(fontSize: 16),
              )
            else
              const Text(
                'Notas: No hay notas disponibles',
                style: TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showStockDetails(context),
              child: const Text('Ver detalles de stock'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }

  void _showStockDetails(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text('Detalles de stock: ${product.name}'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Mostrar la entrada principal
                  _StockCard(
                    entryDate: product.entryDate,
                    expiryDate: product.expiryDate,
                    quantity: product.quantity,
                    grams: product.grams,
                  ),
                  // Mostrar las entradas adicionales
                  ...product.entradas.map((entry) {
                    return _StockCard(
                      entryDate: entry.entryDate,
                      expiryDate: entry.expiryDate,
                      quantity: entry.quantity,
                      grams: entry.grams,
                    );
                  }).toList(),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }
}

class _StockCard extends StatelessWidget {
  final DateTime entryDate;
  final DateTime expiryDate;
  final int quantity;
  final double? grams;

  const _StockCard({
    required this.entryDate,
    required this.expiryDate,
    required this.quantity,
    this.grams,
  });

  @override
  Widget build(BuildContext context) {
    final remainingTime = expiryDate.difference(DateTime.now());
    final remainingText =
        remainingTime.isNegative
            ? 'Expirado'
            : '${remainingTime.inDays} días ${remainingTime.inHours % 24}h';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha de ingreso: ${entryDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Fecha de caducidad: ${expiryDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 14, color: Colors.red),
            ),
            Text('Cantidad: $quantity', style: const TextStyle(fontSize: 14)),
            if (grams != null)
              Text('Gramos: $grams', style: const TextStyle(fontSize: 14)),
            Text(
              'Tiempo restante: $remainingText',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
