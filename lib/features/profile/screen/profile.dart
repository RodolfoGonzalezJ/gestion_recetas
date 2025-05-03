// lib/features/profile/screen/profile.dart
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/navigation/navigation.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/all_recipes.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/recipe_card.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';
import 'widgets/popular_recipe_card.dart';
import 'widgets/ver_todas_button.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 90),

            // Estadísticas
            ProfileStats(user: user),
            const SizedBox(height: 20),

            // Barra de búsqueda
            const SizedBox(height: 10),

            // Receta Popular
            Text("Receta Popular", style: theme.textTheme.titleMedium),
            const PopularRecipeCard(
              imagePath: 'assets/logos/logo.png',
              title: 'Buñuelo asado',
              rating: 4.9,
              reviews: 102,
              duration: 40,
              difficulty: 2,
            ),

            // Mis Recetas (vista previa)
            Text("Mis Recetas", style: theme.textTheme.titleMedium),
            Column(
              children: List.generate(2, (index) {
                // Aquí reemplacé UserRecipeCard por RecipeCard
                return RecipeCard(
                  imagePath: 'assets/logos/logo.png',
                  title: 'Buñuelo asado',
                  rating: 4.9,
                  reviews: 102,
                  duration: 40,
                  difficulty: 3,
                );
              }),
            ),

            // Botón de "Ver todas mis recetas"
            VerTodasButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TodasMisRecetasScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
