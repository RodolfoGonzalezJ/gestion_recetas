import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/screens/login/login.dart';
import 'package:gestion_recetas/features/home/screens/home.dart';
import 'package:gestion_recetas/utils/theme/theme.dart';
import 'package:gestion_recetas/features/auth/screens/signup/signup_page.dart'; // Importa solo el archivo unificado

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Manejo del Tema oscuro y claro
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/signup': (context) => SignUpPage(), // Ruta al archivo unificado
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
