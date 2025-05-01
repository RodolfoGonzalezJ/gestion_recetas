import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';
import 'widgets/popular_recipe_card.dart';
import 'widgets/user_recipe_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = THelperFunctions.isDarkMode(context);

    const user = UserProfile(
      username: 'OzarkPepi',
      name: 'Pepi Por la Calleja',
      bio:
          'Estudiante de Ingeniería, amante de la cocina y los perros. Si ven un patacón, avisan brrr',
      avatarUrl: 'assets/icons/avatar.png',
      recetas: 20,
      vistas: 1,
      seguidores: 1,
      resenas: 20,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: isDark ? CColors.dark : CColors.light,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con fondo + card + botón editar
            Stack(
              clipBehavior: Clip.none,
              children: [
                ProfileHeader(
                  user: user,
                  onEdit: () {
                    // Acción de editar perfil
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ), // Compensación por el solapamiento del header
            // Estadísticas
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
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
              child: ProfileStats(user: user),
            ),
            const SizedBox(height: 20),

            // Barra de búsqueda
            Container(
              decoration: BoxDecoration(
                color: isDark ? CColors.darkContainer : Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                  suffixIcon: Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.grey.shade400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Receta Popular
            Text("Receta Popular", style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            const PopularRecipeCard(
              imagePath: 'assets/logos/logo.png',
              title: 'Buñuelo asado',
              rating: 4.9,
              reviews: 102,
              duration: 40,
              difficulty: 2,
            ),
            const SizedBox(height: 24),

            // Mis Recetas
            Text("Mis Recetas", style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? CColors.darkContainer : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: List.generate(2, (index) {
                  return const UserRecipeCard(
                    imagePath: 'assets/logos/logo.png',
                    title: 'Buñuelo asado',
                    rating: 4.9,
                    reviews: 102,
                    duration: 40,
                    difficulty: 2,
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
