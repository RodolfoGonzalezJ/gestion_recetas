import 'package:gestion_recetas/features/inventory/models/models.dart';

class Recipe {
  final String id;
  final String name;
  final String description;
  final String category;
  final String difficulty;
  final String? imageUrl;
  final String? videoUrl;
  final Duration preparationTime;
  final int? calories;
  final List<Product> ingredients;
  final String? instructions;
  final double averageRating;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    this.imageUrl,
    this.videoUrl,
    required this.preparationTime,
    this.calories,
    required this.ingredients,
    this.instructions,
    this.averageRating = 0.0,
  });

  Recipe copyWith({double? averageRating}) {
    return Recipe(
      id: id,
      name: name,
      description: description,
      category: category,
      difficulty: difficulty,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      preparationTime: preparationTime,
      calories: calories,
      ingredients: ingredients,
      instructions: instructions,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'preparationTime': preparationTime.inMinutes,
      'calories': calories,
      'ingredients': ingredients.map((e) => e.toMap()).toList(),
      'instructions': instructions,
      'averageRating': averageRating,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] ?? 'Otros',
      difficulty: map['difficulty'] as String,
      imageUrl: map['imageUrl'] as String?,
      videoUrl: map['videoUrl'] as String?,
      preparationTime: Duration(minutes: map['preparationTime'] as int),
      calories: map['calories'] as int?,
      ingredients:
          (map['ingredients'] as List)
              .map((e) => Product.fromMap(e as Map<String, dynamic>))
              .toList(),
      instructions: map['instructions'] as String?,
      averageRating: map['averageRating'] as double? ?? 0.0,
    );
  }
}
