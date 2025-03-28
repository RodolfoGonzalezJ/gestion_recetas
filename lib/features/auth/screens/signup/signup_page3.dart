import 'package:flutter/material.dart';

class SignUpPage3 extends StatefulWidget {
  @override
  _SignUpPage3State createState() => _SignUpPage3State();
}

class _SignUpPage3State extends State<SignUpPage3> {
  bool acceptTerms = false;

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
                  Checkbox(
                    value: acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        acceptTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Acepto los términos y condiciones',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed:
                      acceptTerms
                          ? () {
                            // Lógica para crear cuenta
                          }
                          : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) =>
                          states.contains(MaterialState.disabled)
                              ? Colors.green
                              : Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text(
                    'Crear Cuenta',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
