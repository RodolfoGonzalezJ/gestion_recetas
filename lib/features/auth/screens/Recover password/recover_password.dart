import 'package:flutter/material.dart';
import 'package:gestion_recetas/data/services/auth_service.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ingrese su correo electrónico para recuperar su contraseña.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, ingrese un correo electrónico'),
                    ),
                  );
                  return;
                }

                final success = await authService.sendRecoveryEmail(email);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Correo de recuperación enviado'),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'El correo electrónico no está registrado o hubo un error al enviar el correo',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
