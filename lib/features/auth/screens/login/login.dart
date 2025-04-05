import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/screens/login/widgets/login_form.dart';
import 'package:gestion_recetas/features/auth/screens/login/widgets/login_header.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            left: 24,
            bottom: 24,
            right: 24,
          ),
          child: Column(
            children: [
              LoginHeader(dark: dark),
              const SizedBox(height: 30),
              LoginForm(dark: dark),
            ],
          ),
        ),
      ),
    );
  }
}
