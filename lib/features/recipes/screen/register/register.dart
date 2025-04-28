import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/images_recipe_picker.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/recipe_text_fields.dart';
import 'package:gestion_recetas/features/recipes/screen/register/register_2.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class RegisterRecipeScreen extends StatefulWidget {
  const RegisterRecipeScreen({super.key});

  @override
  State<RegisterRecipeScreen> createState() => _RegisterRecipeScreenState();
}

class _RegisterRecipeScreenState extends State<RegisterRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  String? _selectedCategory;
  String? _selectedDifficulty;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _timeController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final color = dark ? Colors.white : CColors.secondaryTextColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar Recetas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            RecipeImagePicker(color: color),
            const SizedBox(height: 16),
            RecipeTextFields(
              nameController: _nameController,
              descController: _descController,
              timeController: _timeController,
              caloriesController: _caloriesController,
              selectedDifficulty: _selectedDifficulty,
              onDifficultyChanged:
                  (val) => setState(() => _selectedDifficulty = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onNextPressed,
              child: const Text("Siguiente"),
            ),
          ],
        ),
      ),
    );
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => RecipeIngredientsStep(
                name: _nameController.text.trim(),
                description: _descController.text.trim(),
                category:
                    _selectedCategory ??
                    '', // Usa '' temporal si no hay categoría seleccionada
                difficulty:
                    _selectedDifficulty ??
                    '', // Usa '' si no seleccionaron dificultad
                preparationTime: _parseDuration(_timeController.text.trim()),
                calories: int.tryParse(_caloriesController.text.trim()),
                imageUrl:
                    null, // Si luego tienes imagen seleccionada puedes pasarla aquí
              ),
        ),
      );
    }
  }

  Duration _parseDuration(String timeString) {
    final parts = timeString.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return Duration(hours: hours, minutes: minutes);
  }
}
