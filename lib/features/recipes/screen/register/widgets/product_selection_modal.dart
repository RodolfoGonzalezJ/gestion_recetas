// lib/features/recipes/screen/register/widgets/product_selection_modal.dart
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';

class ProductSelectionPage extends StatelessWidget {
  final List<Product> products;
  final List<Product> selectedProducts;
  final Function(List<Product>) onSelected;

  const ProductSelectionPage({
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
                final isSelected = selectedProducts.contains(product);
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Cantidad: ${product.quantity}'),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      if (value != null) {
                        if (value) {
                          selectedProducts.add(product);
                        } else {
                          selectedProducts.remove(product);
                        }
                        onSelected(selectedProducts);
                      }
                    },
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
}
