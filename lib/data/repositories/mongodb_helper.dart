import 'package:mongo_dart/mongo_dart.dart';

class MongoDBHelper {
  static Db? _db;

  static Future<void> connect() async {
    if (_db != null && _db!.isConnected) return;
    const connectionString =
        'mongodb+srv://hjpertuz:0813@gestionrecetas.pd25tev.mongodb.net/gestion_recetas?retryWrites=true&w=majority';
    final parsedUri = Db.create(connectionString);
    _db = await parsedUri;
    await _db!.open();
    print('Connected to MongoDB');
  }

  static Db get db {
    if (_db == null || !_db!.isConnected) {
      throw Exception(
        'MongoDB connection is not open. Call MongoDBHelper.connect() first.',
      );
    }
    return _db!;
  }
}
