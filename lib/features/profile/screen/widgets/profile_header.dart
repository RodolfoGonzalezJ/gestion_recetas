import 'package:flutter/material.dart';
import '../../models/user_profile_model.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile user;
  final VoidCallback? onEdit;

  const ProfileHeader({super.key, required this.user, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Fondo decorativo superior
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/logos/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Card blanca con nombre, username y bio
        Positioned(
          top: 75,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              16,
              60,
              16,
              16,
            ), // espacio arriba para el avatar
            decoration: BoxDecoration(
              color: isDark ? CColors.darkContainer : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                ),
                const SizedBox(height: 8),
                Text(
                  user.bio,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        // Avatar centrado sobre la card
        Positioned(
          top: 40,
          child: CircleAvatar(
            radius: 45,
            backgroundImage:
                user.avatarUrl.startsWith('http') ||
                        user.avatarUrl.startsWith('assets')
                    ? NetworkImage(user.avatarUrl) as ImageProvider
                    : AssetImage('assets/icons/avatar.png'),
            backgroundColor: Colors.white,
          ),
        ),

        // Botón de editar (parte superior derecha)
        Positioned(
          top: 16,
          right: 17,
          child: GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: CColors.primaryButton,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
