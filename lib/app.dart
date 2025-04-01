import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/screens/login/login.dart';
import 'package:gestion_recetas/utils/theme/theme.dart';
import 'package:gestion_recetas/features/auth/screens/signup/signup_page1.dart';
import 'package:gestion_recetas/features/auth/screens/signup/signup_page2.dart';
import 'package:gestion_recetas/features/auth/screens/signup/signup_page3.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Manejo del Tema oscuro y claro
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: LoginScreen(),
      routes: {
        '/signup': (context) => SignUpPage1(),
        '/signup2': (context) => SignUpPage2(),
        '/signup3': (context) => SignUpPage3(),
      },
    );
  }
}
