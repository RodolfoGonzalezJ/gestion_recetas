import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class UserRecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double rating;
  final int reviews;
  final int duration;
  final int difficulty;

  const UserRecipeCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.duration,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.star1, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                '$rating · $reviews',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Icon(Iconsax.clock, size: 14),
              const SizedBox(width: 2),
              Text('$duration min', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: List.generate(
              difficulty,
              (_) => const Icon(Iconsax.cup, size: 14, color: Colors.orange),
            ),
          ),
        ],
      ),
      trailing: const Icon(Iconsax.heart),
    );
  }
}
