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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingreso: ${product.entryDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Expira: ${product.expiryDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (product.grams != null)
              Text(
                'Gramos: ${product.grams}',
                style: const TextStyle(fontSize: 16),
              ),
            Text(
              'Cantidad: ${product.quantity}',
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
              child: const Text('Ver más'),
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
                children: List.generate(product.quantity, (index) {
                  return _StockCard(
                    entryDate: product.entryDate,
                    expiryDate: product.expiryDate,
                    unitIndex: index + 1,
                    photoUrl: product.photoUrl,
                  );
                }),
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
  final int unitIndex;
  final String? photoUrl;

  const _StockCard({
    required this.entryDate,
    required this.expiryDate,
    required this.unitIndex,
    this.photoUrl,
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
            Row(
              children: [
                if (photoUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      photoUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 60);
                      },
                    ),
                  )
                else
                  const Icon(Icons.fastfood, size: 60),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Unidad ${unitIndex}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Fecha de ingreso: ${entryDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              'Fecha de caducidad: ${expiryDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 14, color: Colors.red),
            ),
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
