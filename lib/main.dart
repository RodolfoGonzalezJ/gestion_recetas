import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Manejo del Tema oscuro y claro
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      // Cambiamos el tema oscuro por el tema claro
      darkTheme: TAppTheme.darkTheme,
    );
  }
}
