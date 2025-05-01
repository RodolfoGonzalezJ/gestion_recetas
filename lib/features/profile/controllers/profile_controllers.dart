import 'package:get/get.dart';
import '../models/user_profile_model.dart';

class ProfileController extends GetxController {
  final user =
      UserProfile(
        username: 'OzarkPepi',
        name: 'Pepi Por la Calleja',
        bio:
            'Estudiante de Ingeniería, amante de la cocina y los perros. Si ven un patacon, avisan brrr',
        avatarUrl: 'assets/icons/avatar.png',
        recetas: 20,
        vistas: 1000,
        seguidores: 1000,
        resenas: 20,
      ).obs;
}
