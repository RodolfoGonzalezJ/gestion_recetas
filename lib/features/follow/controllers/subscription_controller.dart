import 'package:get/get.dart';
import 'package:gestion_recetas/features/recipes/models/models.dart'; // ya correcto
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import '../services/subscription_service.dart';

class SubscriptionController extends GetxController {
  final isSubscribed = false.obs;
  late UserProfile viewedUser;
  List<Recipe> userRecipes = [];

  Future<void> loadUserProfile(String correo) async {
    viewedUser = await SubscriptionService().fetchUserProfile(correo);
    isSubscribed.value = await SubscriptionService().checkIfSubscribed(correo);
    if (isSubscribed.value) {
      userRecipes = await SubscriptionService().fetchUserRecipes(correo);
    }
  }

  void subscribeToUser(String correo) async {
    await SubscriptionService().subscribe(correo);
    isSubscribed.value = true;
    userRecipes = await SubscriptionService().fetchUserRecipes(correo);
    update();
  }
}
