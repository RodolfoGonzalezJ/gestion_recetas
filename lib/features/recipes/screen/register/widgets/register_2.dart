import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/card.dart';
import 'package:gestion_recetas/common/widgets/text_input_vertical.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'package:gestion_recetas/features/inventory/services/inventory_service.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:gestion_recetas/features/recipes/services/recipe_service.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RecipeIngredientsStep extends StatefulWidget {
  final String name;
  final String description;
  final String category;
  final String difficulty;
  final Duration preparationTime;
  final int? calories;
  final String? imageUrl; // Agregar el campo imageUrl

  const RecipeIngredientsStep({
    super.key,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    required this.preparationTime,
    this.calories,
    this.imageUrl, // Recibir el campo imageUrl
  });

  @override
  State<RecipeIngredientsStep> createState() => _RecipeIngredientsStepState();
}

class _RecipeIngredientsStepState extends State<RecipeIngredientsStep> {
  final TextEditingController instruccionesController = TextEditingController();
  final InventoryService _inventoryService = InventoryService();
  final RecipeService _recipeService = RecipeService();
  List<Product> _selectedIngredients = [];
  late Future<List<Product>> _ingredientsFuture;
  String? _videoPath; // Variable para almacenar la ruta del video

  @override
  void initState() {
    super.initState();
    _ingredientsFuture = _inventoryService.fetchProducts();
  }

  @override
  void dispose() {
    instruccionesController.dispose();
    super.dispose();
  }

  void _toggleIngredientSelection(Product ingredient) {
    setState(() {
      if (_selectedIngredients.contains(ingredient)) {
        _selectedIngredients.remove(ingredient);
      } else {
        _selectedIngredients.add(ingredient);
      }
    });
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoPath = pickedFile.path;
      });
    }
  }

  Future<void> _publishRecipe() async {
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona al menos un ingrediente.'),
        ),
      );
      return;
    }

    final recipe = Recipe(
      id: const Uuid().v4(),
      name: widget.name,
      description: widget.description,
      category: widget.category,
      difficulty: widget.difficulty,
      preparationTime: widget.preparationTime,
      calories: widget.calories,
      ingredients: _selectedIngredients,
      instructions: instruccionesController.text.trim(),
      imageUrl: widget.imageUrl, // Incluir la imagen seleccionada
      videoUrl: _videoPath, // Incluir el video seleccionado (opcional)
    );

    try {
      await _recipeService.saveRecipe(recipe);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receta publicada exitosamente.')),
      );
      Navigator.pop(context); // Regresar a la pantalla anterior
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al publicar la receta: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final textColor = dark ? Colors.white : CColors.primaryTextColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Recetas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Ingredientes',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 12),
            FutureBuilder<List<Product>>(
              future: _ingredientsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error al cargar los ingredientes: ${snapshot.error}',
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No hay ingredientes disponibles.'),
                  );
                } else {
                  final ingredients = snapshot.data!;
                  return Column(
                    children:
                        ingredients.map((ingredient) {
                          final isSelected = _selectedIngredients.contains(
                            ingredient,
                          );
                          return ListTile(
                            title: Text(ingredient.name),
                            subtitle: Text('Cantidad: ${ingredient.quantity}'),
                            trailing: Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isSelected ? Colors.green : null,
                            ),
                            onTap: () => _toggleIngredientSelection(ingredient),
                          );
                        }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 32),
            WTextAreaFormVertical(
              label: 'Instrucciones',
              hint: 'Describe los pasos de tu receta...',
              helperText:
                  'Pasos para realizar la receta.\n(Recuerda realizar por listas)\n\nEj:\n1. Echar la comida en el caldero\n2. Prender el fogón y esperar',
              controller: instruccionesController,
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              'Subir Video Tutorial (Opcional)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _pickVideo,
              child: const Text('Seleccionar Video'),
            ),
            if (_videoPath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Video seleccionado: ${_videoPath!.split('/').last}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _publishRecipe,
              child: const Text('Publicar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
