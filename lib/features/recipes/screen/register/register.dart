import 'package:flutter/material.dart';
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
    final color = dark ? Colors.white : Colors.black;

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

              // Nombre Receta
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre Receta *'),
                // validator: Validators.validateRequired,
              ),
              const SizedBox(height: 12),

              // Descripción
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descripcion *'),
                // validator: Validators.validateRequired,
              ),
              const SizedBox(height: 12),

              // Dificultad
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                items:
                    ['Fácil', 'Media', 'Difícil']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) => setState(() => _selectedDifficulty = val),
                decoration: const InputDecoration(labelText: 'Dificultad *'),
                validator:
                    (value) => value == null ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 12),

              // Tiempo
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Tiempo (HH:MM) *',
                ),
                keyboardType: TextInputType.datetime,
                // validator: VValidators.validateRequired,
              ),
              const SizedBox(height: 12),

              // Calorías
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Calorías'),
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
