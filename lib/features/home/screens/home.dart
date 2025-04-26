import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/home/screens/widgets/floating_menu_button.dart';
import 'package:gestion_recetas/features/inventory/screens/inventory/inventory.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  late Future<List<Recipe>> _recipesFuture;
  final RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _recipesFuture = _recipeService.fetchRecipes();
  }

  final List<Widget> _pages = [
    const Center(child: Text('Inicio')), // Placeholder for the Home page
    const InventoryScreen(), // Inventory page
    const Center(child: Text('Favoritos')), // Placeholder for Favorites page
  ];

  Widget _buildRecipeCard(Recipe recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading:
            recipe.imageUrl != null
                ? Image.file(
                  File(recipe.imageUrl!),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                )
                : const Icon(Icons.fastfood, size: 50),
        title: Text(recipe.name),
        subtitle: Text(recipe.description),
        onTap: () {
          // Acción al tocar una receta (puedes agregar más detalles aquí)
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color iconColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Alimentos'),
        actions: [
          IconButton(icon: const Icon(Icons.face), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body:
          _currentPageIndex == 0
              ? FutureBuilder<List<Recipe>>(
                future: _recipesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error al cargar las recetas: ${snapshot.error}',
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No hay recetas disponibles.'),
                    );
                  } else {
                    final recipes = snapshot.data!;
                    return ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        return _buildRecipeCard(recipes[index]);
                      },
                    );
                  }
                },
              )
              : _pages[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: backgroundColor,
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: iconColor),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.list, color: iconColor),
            label: 'Inventario',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite, color: iconColor),
            label: 'Favoritos',
          ),
        ],
      ),
      floatingActionButton: const FloatingMenuButton(),
    );
  }
}
