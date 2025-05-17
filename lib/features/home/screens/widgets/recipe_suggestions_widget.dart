import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';

class RecipeSuggestionsWidget extends StatelessWidget {
  final List<Recipe> allRecipes;
  final List<Product> allProducts;
  final String currentUserEmail;
  final List<Product>? userProducts;

  const RecipeSuggestionsWidget({
    super.key,
    required this.allRecipes,
    required this.allProducts,
    required this.currentUserEmail,
    this.userProducts,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrar productos no vencidos del usuario
    final now = DateTime.now();
    final availableProducts =
        (userProducts ?? allProducts)
            .where((p) => p.expiryDate.isAfter(now) && p.quantity > 0)
            .toList();

    // Recetas creadas por el usuario
    final userRecipes =
        allRecipes.where((r) => r.createdBy == currentUserEmail).toList();

    // Sugerir recetas que se pueden hacer con los productos disponibles
    final suggestions =
        allRecipes.where((recipe) {
          // Para cada ingrediente de la receta, debe haber un producto disponible con suficiente cantidad
          return recipe.ingredients.every((ingredient) {
            final match = availableProducts.firstWhere(
              (p) => p.name.toLowerCase() == ingredient.name.toLowerCase(),
              orElse:
                  () => Product(
                    id: '',
                    name: '',
                    category: '',
                    entryDate: DateTime.now(),
                    expiryDate: DateTime.now(),
                    grams: 0,
                    quantity: 0,
                    photoUrl: '',
                    notes: '',
                    entradas: [],
                    createdBy: '',
                  ),
            );
            return match.id.isNotEmpty && match.quantity >= ingredient.quantity;
          });
        }).toList();

    if (suggestions.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sugerencias de recetas según tus productos:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('No hay recetas sugeridas con tus productos actuales.'),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sugerencias de recetas según tus productos:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: suggestions.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final recipe = suggestions[index];
              return _RecipeSuggestionCard(recipe: recipe);
            },
          ),
        ),
      ],
    );
  }
}

class _RecipeSuggestionCard extends StatelessWidget {
  final Recipe recipe;

  const _RecipeSuggestionCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                      ? Image.network(
                        recipe.imageUrl!,
                        height: 80,
                        width: 150,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Image.asset(
                              'assets/images/1.png',
                              height: 80,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                      )
                      : Image.asset(
                        'assets/images/1.png',
                        height: 80,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${recipe.preparationTime.inMinutes} min',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 2),
                Text(
                  recipe.averageRating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
