import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/settings/screens/password_security/change_password/change_password_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:gestion_recetas/features/settings/screens/widgets/settings_tile.dart';
import 'widgets/save_button.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contraseña y Seguridad",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SettingsTile(
                  icon: Iconsax.lock_1,
                  title: "Cambiar Contraseña",
                  subtitle: "Contraseña actual",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
                const SettingsTile(
                  icon: Iconsax.scan,
                  title: "Face ID",
                  subtitle: "Not Registered",
                ),
                const SettingsTile(
                  icon: Iconsax.call,
                  title: "Verified Phone Number",
                  subtitle: "Not Registered",
                ),
                const SettingsTile(
                  icon: Iconsax.sms,
                  title: "Verified Email Address",
                  subtitle: "Registered",
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(16), child: SaveButton()),
        ],
      ),
    );
  }
}
