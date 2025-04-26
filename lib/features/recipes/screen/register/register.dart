import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/login/text_input_area_horizontal.dart';
import 'package:gestion_recetas/common/widgets/text_input_horizontal.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/images_recipe_picker.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/recipe_text_fields.dart';
import 'package:gestion_recetas/features/recipes/screen/register/widgets/register_2.dart';
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
        MaterialPageRoute(builder: (_) => const RecipeIngredientsStep()),
      );
    }
  }
}
