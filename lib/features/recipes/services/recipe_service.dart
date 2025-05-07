import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/Comment/models/models.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:gestion_recetas/features/Comment/service/comment_service.dart';

class RecipeService {
  final CommentService _commentService = CommentService();

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      final collection = MongoDBHelper.db.collection('recipes');
      final recipeMap = recipe.toMap();

      // Asegura que el campo _id sea único
      if (recipeMap['_id'] == null || recipeMap['_id'].isEmpty) {
        recipeMap['_id'] = const Uuid().v4();
      }

      // Inserta o actualiza la receta en la base de datos
      await collection.update(
        {'_id': recipeMap['_id']},
        recipeMap,
        upsert: true,
      );
      print('Receta guardada en MongoDB con ID: ${recipeMap['_id']}');
    } catch (e) {
      print('Error al guardar la receta: $e');
      rethrow;
    }
  }

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final collection = MongoDBHelper.db.collection('recipes');
      final recipes = await collection.find().toList();

      // Fetch average ratings for each recipe
      final recipeList = await Future.wait(
        recipes.map((data) async {
          final recipe = Recipe.fromMap(data);
          final averageRating = await _commentService.calculateAverageRating(
            recipe.id,
          );
          return recipe.copyWith(averageRating: averageRating);
        }),
      );

      return recipeList;
    } catch (e) {
      print('Error fetching recipes: $e');
      rethrow;
    }
  }

  Future<int> getTotalRecipes() async {
    try {
      final collection = MongoDBHelper.db.collection('recipes');
      final count =
          await collection.find().length;
      print('Total recipes count: $count'); 
      return count;
    } catch (e) {
      print('Error fetching total recipes count: $e');
      return 0; 
    }
  }

  Future<void> updateRecipe(String id, Map<String, dynamic> updatedData) async {
    try {
      final collection = MongoDBHelper.db.collection('recipes');
      await collection.update({'_id': id}, updatedData);
      print('Receta actualizada en MongoDB');
    } catch (e) {
      print('Error al actualizar la receta: $e');
      rethrow;
    }
  }

  Future<void> deleteRecipe(String id) async {
    try {
      final collection = MongoDBHelper.db.collection('recipes');
      await collection.remove({'_id': id});
      print('Receta eliminada de MongoDB');
    } catch (e) {
      print('Error al eliminar la receta: $e');
      rethrow;
    }
  }

  Future<void> addCommentToRecipe(String recipeId, Comment comment) async {
    try {
      if (recipeId.isEmpty) {
         throw Exception('El ID de la receta no puede estar vacío.');
       }

      // Add the comment
      await _commentService.addComment(comment);

      // Recalculate the average rating
      final averageRating = await _commentService.calculateAverageRating(
        recipeId,
      );

      // Update the recipe with the new average rating
      final collection = MongoDBHelper.db.collection('recipes');
      await collection.update(
        {'_id': recipeId},
        {
          '\$set': {'averageRating': averageRating},
        },
      );
      print('Comentario agregado y rating actualizado.');
    } catch (e) {
      print('Error al agregar comentario a la receta: $e');
      rethrow;
    }
  }
}
