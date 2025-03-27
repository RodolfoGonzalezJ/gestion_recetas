import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/theme/theme.dart';
import 'package:gestion_recetas/features/auth/screens/login_screens.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Manejo del Tema oscuro y claro
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: LoginPage(),
    );
  }
}
