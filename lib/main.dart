import 'package:flutter/material.dart';
import 'package:gestion_recetas/app.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:flutter/services.dart';
import 'package:gestion_recetas/features/Comment/controllers/controllers.dart';
import 'package:gestion_recetas/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:gestion_recetas/providers/data_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await MongoDBHelper.connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentController()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()), // <- Agregado
        ChangeNotifierProvider(create: (context) => DataProvider()),
      ],
      child: const App(),
    ),
  );
}
