import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/Comment/models/models.dart';
import 'package:uuid/uuid.dart';

class CommentService {
  Future<void> addComment(Comment comment) async {
    try {
      final collection = MongoDBHelper.db.collection('comments');
      final commentMap = comment.toMap();

      // Ensure unique ID
      if (commentMap['_id'] == null || commentMap['_id'].isEmpty) {
        commentMap['_id'] = const Uuid().v4();
      }

      await collection.insert(commentMap);
      print('Comentario agregado con éxito.');
    } catch (e) {
      print('Error al agregar el comentario: $e');
      rethrow;
    }
  }

  Future<List<Comment>> fetchComments(String recipeId) async {
    try {
      final collection = MongoDBHelper.db.collection('comments');
      final comments = await collection.find({'recipeId': recipeId}).toList();
      return comments.map((data) => Comment.fromMap(data)).toList();
    } catch (e) {
      print('Error al obtener comentarios: $e');
      rethrow;
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final collection = MongoDBHelper.db.collection('comments');
      await collection.remove({'_id': commentId});
      print('Comentario eliminado con éxito.');
    } catch (e) {
      print('Error al eliminar el comentario: $e');
      rethrow;
    }
  }
}