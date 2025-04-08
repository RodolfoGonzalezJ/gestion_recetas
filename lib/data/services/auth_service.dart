import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';

class AuthService {
  Future<bool> createUser(UserModel user) async {
    try {
      final collection = MongoDBHelper.db.collection('users');
      await collection.insert(user.toJson());
      return true;
    } catch (e) {
      print('Error al crear usuario: $e');
      return false;
    }
  }
}
