// lib/features/profile/screen/all_recipes.dart
import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart';

class TodasMisRecetasScreen extends StatelessWidget {
  const TodasMisRecetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recetas = [
      {
        'image': 'assets/logos/logo.png',
        'title': 'Buñuelo asado',
        'rating': 4.9,
        'reviews': 102,
        'duration': 40,
        'difficulty': 2,
      },
      {
        'image': 'assets/logos/logo.png',
        'title': 'Arepa de huevo',
        'rating': 4.7,
        'reviews': 89,
        'duration': 35,
        'difficulty': 1,
      },
      {
        'image': 'assets/logos/logo.png',
        'title': 'Sancocho costeño',
        'rating': 4.8,
        'reviews': 112,
        'duration': 90,
        'difficulty': 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Todas mis recetas")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recetas.length,
        itemBuilder: (_, index) {
          final r = recetas[index];
          return RecipeCard(
            imagePath: r['image'] as String,
            title: r['title'] as String,
            rating: r['rating'] as double,
            reviews: r['reviews'] as int,
            duration: r['duration'] as int,
            difficulty: r['difficulty'] as int,
          );
        },
      ),
    );
  }
}
