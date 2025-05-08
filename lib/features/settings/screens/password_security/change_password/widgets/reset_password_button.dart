import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/settings/screens/password_security/password_security_screen.dart';

class ResetPasswordButton extends StatelessWidget {
  final bool enabled;

  const ResetPasswordButton({super.key, this.enabled = false});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonHeight = size.height * 0.065;
    final horizontalPadding = size.width * 0.02;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        width: double.infinity,
        height: buttonHeight,
        child: ElevatedButton(
          onPressed:
              enabled
                  ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Contraseña actualizada")),
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const PasswordSecurityScreen(),
                      ),
                      (route) => false,
                    );
                  }
                  : null,

          child: const Text("Cambiar contraseña"),
        ),
      ),
    );
  }
}
