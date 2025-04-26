import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:uuid/uuid.dart';

class RecipeService {
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
      return recipes.map((data) => Recipe.fromMap(data)).toList();
    } catch (e) {
      print('Error fetching recipes: $e');
      rethrow;
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
}
