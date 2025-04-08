import 'package:flutter/material.dart';
import 'package:gestion_recetas/app.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart'; // Import the helper class

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await MongoDBHelper.connect(); // Initialize MongoDB connection
  runApp(const App());
}
