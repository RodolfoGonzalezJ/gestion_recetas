import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/login/text_input_area_horizontal.dart';
import 'package:gestion_recetas/common/widgets/text_input_horizontal.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                'Imagen de la receta *',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: color),
              ),
              SizedBox(height: 8),
              Text(
                'Selecciona una imagen para tu receta',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: color.withOpacity(0.6)),
              ),
              SizedBox(height: 8),
              // Imagen
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    color: CColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: 16),
              WTextInputFormHorizontal(
                label: 'Nombre de Receta',
                hint: 'Escribe el título de la receta',
                controller: _nameController,
              ),

              const SizedBox(height: 12),
              WTextAreaFormHorizontal(
                label: 'Descripcion',
                hint: 'Coloca la descripción de la receta',

                controller: _descController,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                items:
                    ['Fácil', 'Media', 'Difícil']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => _selectedDifficulty = val),
                decoration: const InputDecoration(
                  labelText: 'Dificultad *',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                ),
                validator:
                    (value) => value == null ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Tiempo (HH:MM) *',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calorías',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 15,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Continuar a la siguiente sección
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const RecipeIngredientsStep(),
                    //   ),
                    // );
                  }
                },
                child: const Text("Siguiente"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
