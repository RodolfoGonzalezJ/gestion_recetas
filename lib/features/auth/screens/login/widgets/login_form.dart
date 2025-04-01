import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/button.dart';
import 'package:gestion_recetas/common/widgets/login/TextDivider.dart';
import 'package:gestion_recetas/common/widgets/text_button.dart';
import 'package:gestion_recetas/utils/constants/images_strings.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.dark});

  final bool dark;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;
  bool _rememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Ingrese su correo electrónico',
                labelText: 'Correo electrónico',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                hintText: 'Ingrese su contraseña',
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Iconsax.eye_slash : Iconsax.eye),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 8),
            //CheckBox y Olvidaste tu contraseña
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: _rememberMe, onChanged: _toggleRememberMe),
                    const Text('Recuérdame', style: TextStyle(fontSize: 16)),
                  ],
                ),
                WTextButton(
                  label: 'Olvidaste tu contraseña?',
                  onPressed: () {},
                ),
              ],
            ),

            //Botones de Inicio de Sesión
            const SizedBox(height: 32),
            WButton(label: 'Iniciar Sesión', onPressed: () {}),
            const SizedBox(height: 5),

            // Divider
            TextDivider(widget: widget),
            const SizedBox(height: 5),

            // Botón de Google
            WButton(
              label: 'Iniciar Sesión con Google',
              icon: Image.asset(CImages.googleLogo, height: 24, width: 24),
              isGoogleButton: true,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('No tienes cuenta?', style: TextStyle(fontSize: 15)),
                WTextButton(label: 'Regístrate Aquí', onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
