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
  });

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
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
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
    );
  }
}
