import 'package:flutter/material.dart';
import 'package:gestion_recetas/app.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:flutter/services.dart';
import 'package:gestion_recetas/features/Comment/controllers/controllers.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await MongoDBHelper.connect(); // Initialize MongoDB connection
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentController()),
      ],
      child: const App(),
    ),
  );
}
