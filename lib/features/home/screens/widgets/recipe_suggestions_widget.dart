import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';
import 'package:gestion_recetas/features/inventory/services/inventory_service.dart';
import 'package:gestion_recetas/features/home/screens/detail.dart';

class RecipeSuggestionsWidget extends StatefulWidget {
  final String currentUserEmail;
  const RecipeSuggestionsWidget({super.key, required this.currentUserEmail});

  @override
  State<RecipeSuggestionsWidget> createState() =>
      _RecipeSuggestionsWidgetState();
}

class _RecipeSuggestionsWidgetState extends State<RecipeSuggestionsWidget> {
  late Future<List<Recipe>> _suggestedRecipesFuture;

  @override
  void initState() {
    super.initState();
    if (widget.currentUserEmail.isNotEmpty) {
      _suggestedRecipesFuture = _fetchSuggestedRecipes();
    }
  }

  @override
  void didUpdateWidget(covariant RecipeSuggestionsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentUserEmail != widget.currentUserEmail &&
        widget.currentUserEmail.isNotEmpty) {
      setState(() {
        _suggestedRecipesFuture = _fetchSuggestedRecipes();
      });
    }
  }

  Future<List<Recipe>> _fetchSuggestedRecipes() async {
    final inventoryService = InventoryService();
    final recipeService = RecipeService();

    final userEmail = widget.currentUserEmail;

    final allProducts = await inventoryService.fetchProducts();
    final myProducts =
        allProducts
            .where(
              (p) =>
                  p.createdBy.trim().toLowerCase() ==
                      userEmail.trim().toLowerCase() &&
                  p.expiryDate.isAfter(DateTime.now()) &&
                  p.quantity > 0,
            )
            .toList();

    final allRecipes = await recipeService.fetchRecipes();

    final suggestions = <Recipe>[];
    for (final recipe in allRecipes) {
      bool canMake = true;
      for (final ingredient in recipe.ingredients) {
        final match = myProducts.firstWhere(
          (p) =>
              p.name.trim().toLowerCase() ==
              ingredient.name.trim().toLowerCase(),
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
        if (match.id.isEmpty || match.quantity < ingredient.quantity) {
          canMake = false;
          break;
        }
      }
      if (canMake) {
        suggestions.add(recipe);
      }
    }
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentUserEmail.isEmpty) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<List<Recipe>>(
      future: _suggestedRecipesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Error al cargar sugerencias.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          );
        }
        final suggestions = snapshot.data ?? [];
        if (suggestions.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'No hay recetas sugeridas con tus productos actuales.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
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
              height: 195,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suggestions.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) {
                  final recipe = suggestions[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailPage(recipeId: recipe.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (recipe.imageUrl != null &&
                              recipe.imageUrl!.isNotEmpty)
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: Image.network(
                                  recipe.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 4),
                          Text(
                            recipe.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.green.shade700,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.preparationTime.inMinutes} min',
                                style: const TextStyle(fontSize: 12),
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 14,
                              ),
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
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
