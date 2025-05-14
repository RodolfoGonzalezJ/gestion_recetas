import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../profile/screen/widgets/profile_header.dart';
import '../../profile/screen/widgets/profile_stats.dart';
import '../../profile/screen/widgets/popular_recipe_card.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/subscription_button.dart';
import '../widgets/subscription_modal.dart';

class ProfileSubscriptionPage extends StatelessWidget {
  final String correo;

  const ProfileSubscriptionPage({super.key, required this.correo});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), centerTitle: true),
      body: FutureBuilder(
        future: controller.loadUserProfile(correo,),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.viewedUser;
          final isSubscribed = controller.isSubscribed.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ProfileHeader(user: user),
                const SizedBox(height: 16),

                SubscriptionButton(
                  isSubscribed: isSubscribed,
                  onSubscribe: () {
                    if (!isSubscribed) {
                      showSubscriptionModal(context, () {
                        controller.subscribeToUser(user.correo!);
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),
                ProfileStats(user: user),
                const SizedBox(height: 24),

                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: CColors.primaryButton,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: CColors.dark,
                        tabs: const [
                          Tab(text: 'Mi Contenido'),
                          Tab(text: 'Acerca de mí'),
                        ],
                      ),
                      SizedBox(
                        height: 500,
                        child: TabBarView(
                          children: [
                            _RecipesTab(isSubscribed: isSubscribed),
                            _AboutTab(user: user),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RecipesTab extends StatelessWidget {
  final bool isSubscribed;

  const _RecipesTab({required this.isSubscribed});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    if (!isSubscribed) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Suscríbete para ver las recetas de este usuario.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                showSubscriptionModal(context, () {
                  controller.subscribeToUser(controller.viewedUser.correo!);
                });
              },
              child: const Text('Suscribirse'),
            ),
          ],
        ),
      );
    }

    final List<Recipe> recipes = controller.userRecipes;

    return ListView.separated(
      itemCount: recipes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final recipe = recipes[index];

        return PopularRecipeCard(
          title: recipe.name,
          rating: recipe.averageRating,
          duration: recipe.preparationTime.inMinutes,
          difficulty: _mapDifficultyToInt(recipe.difficulty),
          imagePath: recipe.imageUrl ?? 'assets/icons/avatar.png',
          reviews: recipe.ingredients.length,
        );
      },
    );
  }

  int _mapDifficultyToInt(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'fácil':
        return 1;
      case 'media':
        return 2;
      case 'difícil':
        return 3;
      default:
        return 0;
    }
  }
}

class _AboutTab extends StatelessWidget {
  final UserProfile user;

  const _AboutTab({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            _infoRow('Nombre', '${user.nombre ?? ''} ${user.apellido ?? ''}'),
            _infoRow('Correo', user.correo ?? ''),
            _infoRow('Teléfono', user.celular ?? 'No disponible'),
            _infoRow('Ubicación', user.pais ?? 'Sin ubicación'),
            _infoRow(
              'Fecha nacimiento',
              user.fechaNacimiento?.toString().split(' ').first ??
                  'No disponible',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
