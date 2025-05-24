import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/iconButtonBox.dart';
import 'package:gestion_recetas/features/profile/screen/profile.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 20.0),
      child: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
          child: IconButtonBox(
            imagePath:
                isDark ? 'assets/logos/logo3.png' : 'assets/logos/logo.png',
            onTap: () {},
          ),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap:
                    () => THelperFunctions.navigateToScreen(
                      context,
                      ProfileScreen(),
                    ),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/logos/Ellipse 2.png'),
                ),
              ),
              const SizedBox(width: 16),
              IconButtonBox(
                imagePath:
                    isDark
                        ? 'assets/logos/notification_dark.png'
                        : 'assets/logos/Frame.png',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
