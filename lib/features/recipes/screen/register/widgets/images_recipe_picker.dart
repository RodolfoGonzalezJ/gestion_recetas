import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class RecipeImagePicker extends StatelessWidget {
  final Color color;

  const RecipeImagePicker({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Imagen de la receta *',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona una imagen para tu receta',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: color.withOpacity(0.6)),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Lógica para seleccionar imagen
          },
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: CColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.add, color: Colors.white, size: 40),
            ),
          ),
        ),
      ],
    );
  }
}
