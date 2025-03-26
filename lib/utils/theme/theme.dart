import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/theme/custom_themes/text_theme.dart';

//Usamos la Letra T para refenciar a Theme
//y clase
class TAppTheme {
  //Creamos un constructor privado
  TAppTheme._();
  //Creamos unass variables de tipo ThemeData
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color.fromRGBO(25, 131, 48, 100),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromRGBO(25, 131, 48, 100),
        ),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(25, 131, 48, 100),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
  );
}
