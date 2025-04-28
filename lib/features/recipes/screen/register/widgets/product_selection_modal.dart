// lib/features/recipes/screen/register/widgets/product_selection_modal.dart
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';

class ProductSelectionPage extends StatelessWidget {
  final List<Product> products;
  final List<Product> selectedProducts;
  final Function(List<Product>) onSelected;

  // Mapa para rastrear la cantidad seleccionada de cada producto
  final Map<String, int> selectedQuantities = {};

  ProductSelectionPage({
    Key? key,
    required this.products,
    required this.selectedProducts,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400, // Altura del modal
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selecciona los productos',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                // Verificar si el producto está seleccionado
                final isSelected = selectedProducts.any(
                  (p) => p.id == product.id,
                );
                // Obtener la cantidad seleccionada o 0 si no está seleccionada
                int selectedQuantity = selectedQuantities[product.id] ?? 0;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text('Cantidad disponible: ${product.quantity}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed:
                              selectedQuantity > 0
                                  ? () {
                                    selectedQuantity--;
                                    selectedQuantities[product.id] =
                                        selectedQuantity;
                                    _updateSelectedProducts(
                                      product,
                                      selectedQuantity,
                                    );
                                  }
                                  : null,
                        ),
                        Text(selectedQuantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed:
                              selectedQuantity < product.quantity
                                  ? () {
                                    selectedQuantity++;
                                    selectedQuantities[product.id] =
                                        selectedQuantity;
                                    _updateSelectedProducts(
                                      product,
                                      selectedQuantity,
                                    );
                                  }
                                  : null,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _updateSelectedProducts(Product product, int quantity) {
    if (quantity > 0) {
      // Si la cantidad es mayor a 0, se agrega o actualiza el producto en la lista seleccionada
      final existingProduct = selectedProducts.firstWhere(
        (p) => p.id == product.id,
        orElse:
            () => Product(
              id: product.id,
              name: product.name,
              category: product.category,
              entryDate: product.entryDate,
              expiryDate: product.expiryDate,
              grams: product.grams,
              quantity: product.quantity, // Mantener la cantidad original
            ),
      );

      // Aquí no intentamos modificar la cantidad del producto original
      // Solo actualizamos la lista de seleccionados
      if (!selectedProducts.contains(existingProduct)) {
        selectedProducts.add(existingProduct);
      }
    } else {
      // Si la cantidad es 0, se elimina el producto de la lista seleccionada
      selectedProducts.removeWhere((p) => p.id == product.id);
    }
    onSelected(selectedProducts);
  }
}
