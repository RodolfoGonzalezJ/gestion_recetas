// lib/features/profile/screen/all_recipes.dart
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import '../widgets/recipe_card.dart';

class TodasMisRecetasScreen extends StatelessWidget {
  final List<Recipe> recetasUsuario;

  const TodasMisRecetasScreen({super.key, required this.recetasUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todas mis recetas")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recetasUsuario.length,
        itemBuilder: (_, index) {
          final receta = recetasUsuario[index];
          return RecipeCard(
            id: receta.id,
            imagePath: receta.imageUrl ?? 'assets/logos/logo.png',
            title: receta.name,
            rating: receta.averageRating,
            reviews: 0,
            duration: receta.preparationTime.inMinutes,
            difficulty: int.tryParse(receta.difficulty) ?? 1,
          );
        },
      ),
    );
  }
}
