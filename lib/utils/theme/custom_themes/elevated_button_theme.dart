import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  static ElevatedButtonThemeData
  lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(25, 131, 48, 100),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      side: const BorderSide(color: Color.fromRGBO(25, 131, 48, 100), width: 1),
      textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
  static ElevatedButtonThemeData
  darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(25, 131, 48, 100),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      side: const BorderSide(color: Color.fromRGBO(25, 131, 48, 100), width: 1),
      textStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
  );
}
