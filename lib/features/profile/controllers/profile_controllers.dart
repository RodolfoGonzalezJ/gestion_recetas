// lib/features/profile/controllers/profile_controller.dart

import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';

class ProfileController {
  late final UserModel userModel;
  late final UserProfile userProfile;

  ProfileController() {
    // Inicializa manualmente el modelo de usuario
    userModel = UserModel(
      nombre: 'Pepi',
      apellido: 'Por la Calleja',
      celular: '3001234567',
      cedula: '1234567890',
      fechaNacimiento: DateTime(2000, 1, 1),
      correo: 'ozarkpepi@example.com',
      pais: 'Colombia',
      departamento: 'Cesar',
      municipio: 'Valledupar',
      direccion: 'Calle Falsa 123',
      barrio: 'Centro',
      contrasena: '••••••••',
    );

    // Construye el perfil desde el modelo
    userProfile = UserProfile(
      nombre: userModel.nombre,
      apellido: userModel.apellido,
      celular: userModel.celular,
      cedula: userModel.cedula,
      fechaNacimiento: userModel.fechaNacimiento,
      correo: userModel.correo,
      pais: userModel.pais,
      departamento: userModel.departamento,
      municipio: userModel.municipio,
      direccion: userModel.direccion,
      barrio: userModel.barrio,
      contrasena: userModel.contrasena,

      username: userModel.correo ?? '',
      bio: 'Estudiante de Ingeniería, amante de la cocina y los perros.',
      avatarUrl: 'assets/icons/avatar.png',
      recetas: 20,
      vistas: 1,
      seguidores: 1,
      resenas: 20,
    );
  }
}
