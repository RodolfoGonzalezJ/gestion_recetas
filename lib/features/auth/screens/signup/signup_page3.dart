import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/button.dart';
import 'package:gestion_recetas/features/auth/screens/signup/verify_emai.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class SignUpPage3 extends StatefulWidget {
  const SignUpPage3({super.key});

  @override
  _SignUpPage3State createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  bool acceptTerms = false;
  bool _obscureText = true;
  bool _rememberMe = false;

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logos/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Enter your details below',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Crear Cuenta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: _toggleRememberMe,
                          ),
                          const Text(
                            'Acepto los términos y condiciones',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              WButton(
                label: 'Crear Cuenta',
                onPressed: () {
                  THelperFunctions.navigateToScreen(
                    context,
                    VerifyEmailScreen(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
