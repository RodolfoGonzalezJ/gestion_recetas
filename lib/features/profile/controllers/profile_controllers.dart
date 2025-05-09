import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';

class ProfileController {
  UserModel? userModel;
  UserProfile? userProfile;

  /// Carga los datos del usuario desde la base de datos
  Future<void> loadUserProfile(String email) async {
    if (email.isEmpty) {
      print('El correo está vacío. No se puede cargar el perfil.');
      return;
    }

    try {
      print('Buscando datos para el correo: $email');
      final collection = MongoDBHelper.db.collection('users');

      // Validar el correo
      email = email.trim().toLowerCase();

      // Depurar: listar todos los usuarios
      final allUsers = await collection.find().toList();
      print('Usuarios en la base de datos: $allUsers');

      final userData = await collection.findOne({'correo': email});

      if (userData != null && userData['fechaNacimiento'] != null) {
        final fechaNacimiento = DateTime.parse(userData['fechaNacimiento']);
        if (fechaNacimiento.isAfter(DateTime.now())) {
          print('Error: La fecha de nacimiento no puede estar en el futuro.');
          return;
        }
      } else {
        print('Error: Datos de usuario o fecha de nacimiento no disponibles.');
        return;
      }

      if (userData != null) {
        print('Datos encontrados: $userData');
        userProfile = UserProfile(
          nombre: userData['nombre'] ?? 'Nombre no disponible',
          apellido: userData['apellido'] ?? '',
          celular: userData['celular'] ?? '',
          cedula: userData['cedula'] ?? '',
          fechaNacimiento: DateTime.parse(userData['fechaNacimiento']),
          correo: userData['correo'] ?? '',
          pais: userData['pais'] ?? '',
          departamento: userData['departamento'] ?? '',
          municipio: userData['municipio'] ?? '',
          direccion: userData['direccion'] ?? '',
          barrio: userData['barrio'] ?? '',
          contrasena: userData['contrasena'] ?? '',
          username: userData['correo'] ?? 'Usuario',
          bio: userData['bio'] ?? 'Sin biografía',
          avatarUrl: userData['avatarUrl'] ?? 'assets/icons/avatar.png',
          recetas: userData['recetas'] ?? 0,
          vistas: userData['vistas'] ?? 0,
          seguidores: userData['seguidores'] ?? 0,
          resenas: userData['resenas'] ?? 0,
        );
      } else {
        print('No se encontraron datos para el usuario con correo: $email');
      }
    } catch (e) {
      print('Error al cargar el perfil del usuario: $e');
    }
  }
}
