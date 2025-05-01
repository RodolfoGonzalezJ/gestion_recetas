import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PopularRecipeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double rating;
  final int reviews;
  final int duration;
  final int difficulty;

  const PopularRecipeCard({
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

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Iconsax.star1, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      '$rating · $reviews Reviews',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Icon(Iconsax.clock, size: 16),
                    const SizedBox(width: 4),
                    Text('$duration min', style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    difficulty,
                    (_) =>
                        const Icon(Iconsax.cup, size: 14, color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Iconsax.heart),
        ],
      ),
    );
  }
}
