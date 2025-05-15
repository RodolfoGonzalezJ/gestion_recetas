import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/follow/widgets/subscription_modal.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/recipe_card.dart';

class TodasMisRecetasScreen extends StatefulWidget {
  const TodasMisRecetasScreen({super.key});

  @override
  State<TodasMisRecetasScreen> createState() => _TodasMisRecetasScreenState();
}

class _TodasMisRecetasScreenState extends State<TodasMisRecetasScreen> {
  bool _showBlur = true;

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

  @override
  void initState() {
    super.initState();

    // Ejecutar después del build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSubscriptionModal(context, () {
        setState(() => _showBlur = false); // quitar el blur
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todas mis recetas")),
      body: Stack(
        children: [
          // Contenido principal
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recetas.length,
            itemBuilder: (_, index) {
              final r = recetas[index];
              return RecipeCard(
                id: index.toString(),
                imagePath: r['image'] as String,
                title: r['title'] as String,
                rating: r['rating'] as double,
                reviews: r['reviews'] as int,
                duration: r['duration'] as int,
                difficulty: r['difficulty'] as int,
              );
            },
          ),

          // Desenfoque si está activo
          if (_showBlur)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
        ],
      ),
    );
  }
}
