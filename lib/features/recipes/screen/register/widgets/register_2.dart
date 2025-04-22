import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/card.dart';
import 'package:gestion_recetas/common/widgets/text_input_vertical.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class RecipeIngredientsStep extends StatefulWidget {
  const RecipeIngredientsStep({super.key});

  @override
  State<RecipeIngredientsStep> createState() => _RecipeIngredientsStepState();
}

class _RecipeIngredientsStepState extends State<RecipeIngredientsStep> {
  final TextEditingController instruccionesController = TextEditingController();

  @override
  void dispose() {
    instruccionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final textColor = dark ? Colors.white : CColors.primaryTextColor;
    final subTextColor = dark ? Colors.grey.shade400 : Colors.grey.shade600;

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
              'Ingredientes ',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              '*',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Ingredientes añadidos
            const IngredienteCard(
              nombre: 'Espaguetty Doria',
              cantidad: '2',
              unidad: '500g',
              imagen: 'assets/logos/logo.png',
            ),
            const IngredienteCard(
              nombre: 'Tomate',
              cantidad: '1',
              unidad: '80g',
              imagen: 'assets/logos/logo.png',
            ),
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  // lógica para agregar nuevo ingrediente
                },
                mini: true,
                backgroundColor: CColors.primaryColor,
                child: const Icon(Icons.add, color: Colors.white),
              ),
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
              'Subir Video Tutorial',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    dark ? CColors.textMore : Colors.green.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: const Text('Subir archivo desde tu dispositivo'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // publicar receta
              },
              child: const Text('Publicar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
