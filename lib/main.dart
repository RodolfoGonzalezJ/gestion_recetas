import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gestion_recetas/app.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:flutter/services.dart';
import 'package:gestion_recetas/features/Comment/controllers/controllers.dart';
import 'package:gestion_recetas/features/favorites/controllers/favorite_controller.dart';
import 'package:gestion_recetas/features/follow/widgets/keys.dart';
import 'package:gestion_recetas/utils/theme/custom_themes/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:gestion_recetas/providers/data_provider.dart';
import 'package:gestion_recetas/features/notifications/notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PublishableKey;
  await Stripe.instance.applySettings();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await MongoDBHelper.connect();
  await NotificationService.initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommentController()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()), // <- Agregado
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoriteController(),
        ), // <-- Agregado
      ],
      child: const App(),
    ),
  );
}
