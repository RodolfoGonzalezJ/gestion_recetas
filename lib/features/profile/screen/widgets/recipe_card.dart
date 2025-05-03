import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/difficulty.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class RecipeCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final double rating;
  final int reviews;
  final int duration;
  final int difficulty;

  /// Si no se provee, el estado se maneja internamente
  final bool? isFavorite;
  final ValueChanged<bool>? onFavoriteTap;

  const RecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.duration,
    required this.difficulty,
    this.isFavorite,
    this.onFavoriteTap,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  late bool _localFavorite;

  @override
  void initState() {
    super.initState();
    _localFavorite = widget.isFavorite ?? false;
  }

  void _toggleFavorite() {
    if (widget.onFavoriteTap != null) {
      widget.onFavoriteTap!(!(widget.isFavorite ?? _localFavorite));
    } else {
      setState(() => _localFavorite = !_localFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final favorite = widget.isFavorite ?? _localFavorite;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      color: isDark ? CColors.darkContainer : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // Contenido
            Expanded(
              child: Stack(
                children: [
                  // Contenido principal
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),

                      // Rating y duración
                      Row(
                        children: [
                          const Icon(
                            Iconsax.star1,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.rating} | ${widget.reviews} reseñas',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Iconsax.clock_14,
                            size: 16,
                            color: CColors.primaryButton,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.duration} min',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Dificultad
                      Text(
                        'Dificultad',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      DifficultyIndicator(level: widget.difficulty),
                    ],
                  ),

                  // Corazón abajo a la derecha
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Icon(
                        favorite ? Iconsax.heart5 : Iconsax.heart,
                        color: favorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
