import 'package:flutter/material.dart';
import 'recipe_card.dart';

class PopularRecipeCard extends StatefulWidget {
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
  State<PopularRecipeCard> createState() => _PopularRecipeCardState();
}

class _PopularRecipeCardState extends State<PopularRecipeCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return RecipeCard(
      id: UniqueKey().toString(), 
      imagePath: widget.imagePath,
      title: widget.title,
      rating: widget.rating,
      reviews: widget.reviews,
      duration: widget.duration,
      difficulty: widget.difficulty,
      isFavorite: isFav,
      onFavoriteTap: (newValue) {
        setState(() => isFav = newValue);
      },
    );
  }
}
