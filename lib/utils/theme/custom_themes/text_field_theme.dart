import 'package:flutter/material.dart';

class TTextFieldTheme {
  TTextFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    labelStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 16),
    hintStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 16),
    errorStyle: const TextStyle().copyWith(
      fontSize: 16,
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: const Color.fromARGB(112, 0, 0, 0),
      fontSize: 16,
    ),
    border: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.black, width: 1.5),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.orange, width: 1.5),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    labelStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 16),
    hintStyle: const TextStyle().copyWith(color: Colors.black, fontSize: 16),
    errorStyle: const TextStyle().copyWith(
      fontSize: 16,
      fontStyle: FontStyle.normal,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: const Color.fromARGB(112, 0, 0, 0),
      fontSize: 16,
    ),
    border: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.grey, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.black, width: 1.5),
    ),
    errorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14.0),
      borderSide: BorderSide(color: Colors.orange, width: 1.5),
    ),
  );
}
