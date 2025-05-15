import '../../profile/models/user_profile_model.dart';
import '../../recipes/models/models.dart';

class SubscriptionService {
  Future<bool> checkIfSubscribed(String correo) async {
    // Aquí va la lógica real con MongoDB o cache
    await Future.delayed(const Duration(milliseconds: 500));
    return false;
  }

  Future<void> subscribe(String correo) async {
    // Aquí guardarías la suscripción en la base de datos
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<UserProfile> fetchUserProfile(String correo) async {
    // Simula datos (reemplaza por consulta real)
    return UserProfile(
      username: 'OzarkPepi',
      bio: 'Estudiante de ingeniería, amante de la cocina y los perros.',
      avatarUrl: 'assets/icons/avatar.png',
      recetas: 20,
      vistas: 40000,
      seguidores: 16,
      resenas: 4,
      correo: correo,
      nombre: 'Pepi',
      apellido: 'Por la Calleja',
      celular: '3191233129',
      pais: 'Colombia',
      direccion: 'Cra 123',
      barrio: 'Barrio lindo',
      fechaNacimiento: DateTime(2000, 1, 1),
    );
  }

  Future<List<Recipe>> fetchUserRecipes(String correo) async {
    return [
      Recipe(
        id: '1',
        name: 'Buñuelo asado',
        description: 'Delicioso buñuelo sin freír',
        category: 'Postres',
        difficulty: 'Fácil',
        imageUrl: 'assets/images/brocoli.png',
        videoUrl: null,
        preparationTime: const Duration(minutes: 40),
        calories: 200,
        ingredients: [], // ← simulado vacío, ajusta si necesitas
        instructions: 'Mezclar, hornear y disfrutar.',
        averageRating: 4.5,
        createdBy:["id"] as String,
      ),
    ];
  }
}
