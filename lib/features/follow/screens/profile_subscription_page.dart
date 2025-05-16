import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/follow/screens/subscribed_recipes_page.dart';
import 'package:gestion_recetas/features/follow/widgets/profile_header_follow.dart';
import 'package:gestion_recetas/features/follow/widgets/subscription_button.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/profile_stats.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/popular_recipe_card.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/recipe_card.dart';
import 'package:gestion_recetas/features/profile/screen/widgets/ver_todas_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class ProfileSubscriptionPage extends StatefulWidget {
  final String correo;
  final String nombre;
  final String apellido;
  final String avatarUrl;

  const ProfileSubscriptionPage({
    Key? key,
    required this.correo,
    required this.nombre,
    required this.apellido,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  State<ProfileSubscriptionPage> createState() =>
      _ProfileSubscriptionPageState();
}

class _ProfileSubscriptionPageState extends State<ProfileSubscriptionPage> {
  int selectedTabIndex = 0;
  late final UserProfile userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = UserProfile(
      nombre: widget.nombre,
      apellido: widget.apellido,
      recetas: 24,
      vistas: 3.5,
      seguidores: 1.2,
      resenas: 52,
      username: widget.correo.split('@').first,
      bio: "Soy un apasionado de la cocina y me encanta compartir mis recetas.",
      avatarUrl: widget.avatarUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? CColors.dark : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        elevation: 2,
        toolbarHeight: 38, // Reduce la altura del AppBar
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 8 : 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(user: userProfile),
            const SizedBox(height: 60),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 0),
              child: ProfileStats(user: userProfile),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: SizedBox(
                width: double.infinity,
                child: StyledSubscriptionButton(
                  onPressed: () {
                    // Acción de suscripción
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                _buildTabButton("Mi Contenido", 0),
                const SizedBox(width: 16),
                _buildTabButton("Acerca de mí", 1),
              ],
            ),

            const SizedBox(height: 24),

            if (selectedTabIndex == 0) ...[
              Text("Receta Popular", style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              const PopularRecipeCard(
                imagePath: 'assets/logos/logo.png',
                title: 'Buñuelo asado',
                rating: 4.9,
                reviews: 102,
                duration: 40,
                difficulty: 2,
              ),
              const SizedBox(height: 20),
              Text("Mis Recetas", style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              RecipeCard(
                id: '1',
                imagePath: 'assets/logos/logo.png',
                title: 'Buñuelo asado',
                rating: 4.9,
                reviews: 102,
                duration: 40,
                difficulty: 3,
              ),
              RecipeCard(
                id: '2',
                imagePath: 'assets/logos/logo.png',
                title: 'Empanada verde',
                rating: 4.7,
                reviews: 89,
                duration: 35,
                difficulty: 2,
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
            ] else ...[
              Text(
                'Acerca de mí',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                "Trayectoria:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Más de 8 años como chef profesional. Especialista en platos vegetarianos y sin gluten.",
              ),
            ],

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected) Container(height: 2, width: 60, color: Colors.green),
        ],
      ),
    );
  }
}
