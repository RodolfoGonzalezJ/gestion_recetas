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
      title: Text(
        product.name.isNotEmpty ? product.name : 'Producto sin nombre',
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isValidNetworkUrl(product.photoUrl))
              Center(
                child: Image.network(
                  product.photoUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              )
            else
              const Center(child: Icon(Icons.fastfood, size: 100)),
            const SizedBox(height: 16),
            Text(
              'Categoría: ${product.category.isNotEmpty ? product.category : 'Sin categoría'}',
            ),
            Text(
              'Fecha de ingreso: ${product.entryDate.toLocal()}'.split(' ')[0],
            ),
            Text(
              'Fecha de caducidad: ${product.expiryDate.toLocal()}'.split(
                ' ',
              )[0],
            ),
            if (product.grams != null) Text('Gramos: ${product.grams}'),
            Text('Cantidad: ${product.quantity}'),
            if (product.notes != null && product.notes!.isNotEmpty)
              Text('Notas: ${product.notes}')
            else
              const Text('Notas: No hay notas disponibles'),
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
}
