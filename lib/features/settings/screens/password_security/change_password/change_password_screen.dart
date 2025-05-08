import 'package:flutter/material.dart';
import 'widgets/password_input_field.dart';
import 'widgets/reset_password_button.dart';
import 'widgets/password_validator_checklist.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _passwordIsValid = false;

  void _onPasswordChanged(String value) {
    // No hacemos setState aquí directamente, lo hace el checklist por callback
  }

  void _onConfirmChanged(String value) {
    setState(() {});
  }

  bool get _canSubmit =>
      _passwordIsValid && _confirmController.text == _passwordController.text;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cambiar Contraseña",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: isDark ? Colors.white : Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Su nueva contraseña debe ser diferente a las contraseñas utilizadas anteriormente.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            PasswordInputField(
              label: "Contraseña",
              hintText: "Debe tener al menos 8 caracteres.",
              controller: _passwordController,
              onChanged: _onPasswordChanged,
            ),
            const SizedBox(height: 12),
            PasswordValidatorChecklist(
              password: _passwordController.text,
              onValidationChanged: (isValid) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _passwordIsValid = isValid;
                    });
                  }
                });
              },
            ),

            const SizedBox(height: 24),
            PasswordInputField(
              label: "Confirmar Contraseña",
              hintText: "Ambas contraseñas deben coincidir.",
              controller: _confirmController,
              onChanged: _onConfirmChanged,
            ),

            const Spacer(),
            ResetPasswordButton(enabled: _canSubmit),
          ],
        ),
      ),
    );
  }
}
