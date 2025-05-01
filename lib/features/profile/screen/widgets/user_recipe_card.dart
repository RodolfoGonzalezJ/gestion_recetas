import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
    final theme = Theme.of(context);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Iconsax.star1, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text('$rating · $reviews', style: theme.textTheme.bodySmall),
              const SizedBox(width: 8),
              Icon(Iconsax.clock, size: 14),
              const SizedBox(width: 2),
              Text('$duration min', style: theme.textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 2),
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
