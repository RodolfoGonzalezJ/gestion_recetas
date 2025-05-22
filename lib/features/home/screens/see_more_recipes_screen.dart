import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/features/home/screens/detail.dart';

class SeeMoreRecipesScreen extends StatelessWidget {
  final String title;
  final List<Recipe> recipes;

  const SeeMoreRecipesScreen({
    Key? key,
    required this.title,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body:
          recipes.isEmpty
              ? const Center(child: Text('No hay recetas para mostrar.'))
              : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return ListTile(
                    leading:
                        recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty
                            ? Image.network(
                              recipe.imageUrl!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    'assets/images/1.png',
                                    width: 56,
                                    height: 56,
                                  ),
                            )
                            : Image.asset(
                              'assets/images/1.png',
                              width: 56,
                              height: 56,
                            ),
                    title: Text(recipe.name),
                    subtitle: Text(
                      'Rating: ${recipe.averageRating.toStringAsFixed(1)} | ${recipe.difficulty}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailPage(recipeId: recipe.id),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
