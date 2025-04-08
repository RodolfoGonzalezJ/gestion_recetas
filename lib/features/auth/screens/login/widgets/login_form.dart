import 'package:flutter/material.dart';
import 'package:gestion_recetas/common/widgets/button.dart';
import 'package:gestion_recetas/common/widgets/login/TextDivider.dart';
import 'package:gestion_recetas/common/widgets/text_button.dart';
import 'package:gestion_recetas/features/auth/screens/signup/signup_page.dart';
import 'package:gestion_recetas/utils/constants/images_strings.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:gestion_recetas/utils/validators/validators.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.dark});

  final bool dark;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Aquí iría tu lógica de inicio de sesión
      print('Correo: ${_emailController.text}');
      print('Contraseña: ${_passwordController.text}');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Ingrese su correo electrónico',
                  labelText: 'Correo electrónico',
                ),
                validator: VValidators.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  hintText: 'Ingrese su contraseña',
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Iconsax.eye_slash : Iconsax.eye),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: VValidators.validatePassword,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: _toggleRememberMe,
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      const Text(
                        'Recuérdame',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  WTextButton(
                    label: 'Olvidaste tu\ncontraseña?',
                    onPressed: () {},
                  ),
                ],
              ),

              WButton(label: 'Iniciar Sesión', onPressed: _submitForm),

              TextDivider(widget: widget),

              WButton(
                label: 'Iniciar Sesión con Google',
                icon: Image.asset(CImages.googleLogo, height: 24, width: 24),
                isGoogleButton: true,
                onPressed: () {},
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'No tienes cuenta?',
                    style: TextStyle(fontSize: 15),
                  ),
                  WTextButton(
                    label: 'Regístrate Aquí',
                    onPressed: () {
                      THelperFunctions.navigateToScreen(context, SignUpPage());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
