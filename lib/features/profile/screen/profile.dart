// lib/features/profile/screen/profile.dart
import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/profile/controllers/profile_controllers.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/features/profile/screen/edit_profile.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/all_recipes.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/recipe_card.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';
import 'widgets/popular_recipe_card.dart';
import 'widgets/ver_todas_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = ProfileController(); // Instancia sin GetX
  }

  @override
  Widget build(BuildContext context) {
    final UserProfile userProfile = _ctrl.userProfile;
    final theme = Theme.of(context);
    final isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: theme.textTheme.titleLarge),
        backgroundColor: isDark ? CColors.dark : CColors.light,
        iconTheme: IconThemeData(
          color: isDark ? CColors.light : CColors.secondaryTextColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ProfileHeader(
                  user: userProfile,
                  onEdit: () {
                    THelperFunctions.navigateToScreen(
                      context,
                      EditProfileScreen(user: userProfile),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 90),
            ProfileStats(user: userProfile),
            const SizedBox(height: 20),
            Text("Receta Popular", style: theme.textTheme.titleMedium),
            const PopularRecipeCard(
              imagePath: 'assets/logos/logo.png',
              title: 'Buñuelo asado',
              rating: 4.9,
              reviews: 102,
              duration: 40,
              difficulty: 2,
            ),
            Text("Mis Recetas", style: theme.textTheme.titleMedium),
            Column(
              children: List.generate(2, (index) {
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
