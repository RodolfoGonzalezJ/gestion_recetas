import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/auth/models/models.dart';
import 'package:gestion_recetas/data/services/auth_service.dart';
import 'package:gestion_recetas/data/services/google_auth_service.dart';
import 'package:gestion_recetas/data/repositories/mongodb_helper.dart';
import 'package:gestion_recetas/features/home/screens/home.dart';
class AuthController {
  final AuthService _authService = AuthService();
  final UserModel _user = UserModel();

  UserModel get user => _user;

  void updateUserField(String field, dynamic value) {
    switch (field) {
      case 'nombre':
        _user.nombre = value;
        break;
      case 'apellido':
        _user.apellido = value;
        break;
      case 'celular':
        _user.celular = value;
        break;
      case 'cedula':
        _user.cedula = value;
        break;
      case 'fechaNacimiento':
        _user.fechaNacimiento = value;
        break;
      case 'correo':
        _user.correo = value;
        break;
      case 'pais':
        _user.pais = value;
        break;
      case 'departamento':
        _user.departamento = value;
        break;
      case 'municipio':
        _user.municipio = value;
        break;
      case 'direccion':
        _user.direccion = value;
        break;
      case 'barrio':
        _user.barrio = value;
        break;
      case 'contrasena':
        _user.contrasena = value;
        break;
    }
  }

  List<String> getMissingFields() {
    List<String> missingFields = [];
    if (_user.nombre == null || _user.nombre!.isEmpty)
      missingFields.add('Nombre');
    if (_user.apellido == null || _user.apellido!.isEmpty)
      missingFields.add('Apellido');
    if (_user.celular == null || _user.celular!.isEmpty)
      missingFields.add('Número de Celular');
    if (_user.cedula == null || _user.cedula!.isEmpty)
      missingFields.add('Número de Cédula');
    if (_user.fechaNacimiento == null) missingFields.add('Fecha de Nacimiento');
    if (_user.correo == null || _user.correo!.isEmpty)
      missingFields.add('Correo Electrónico');
    if (_user.pais == null || _user.pais!.isEmpty) missingFields.add('País');
    if (_user.departamento == null || _user.departamento!.isEmpty)
      missingFields.add('Departamento');
    if (_user.municipio == null || _user.municipio!.isEmpty)
      missingFields.add('Municipio');
    if (_user.direccion == null || _user.direccion!.isEmpty)
      missingFields.add('Dirección');
    if (_user.barrio == null || _user.barrio!.isEmpty)
      missingFields.add('Barrio');
    if (_user.contrasena == null || _user.contrasena!.isEmpty)
      missingFields.add('Contraseña');
    return missingFields;
  }

  Future<void> registerUser(BuildContext context) async {
    List<String> missingFields = getMissingFields();
    if (missingFields.isEmpty) {
      final success = await _authService.createUser(_user);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuario registrado exitosamente')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al registrar usuario')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Faltan los siguientes campos: ${missingFields.join(', ')}',
          ),
        ),
      );
    }
  }

  Future<bool> isCedulaDuplicated(String cedula) async {
    return await _authService.isCedulaDuplicated(cedula);
  }

  Future<bool> isEmailDuplicated(String email) async {
    return await _authService.isEmailDuplicated(email);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final googleUser = await GoogleAuthService.signInWithGoogle();
    if (googleUser != null) {
      final email = googleUser.email;
      final name = googleUser.displayName ?? 'Usuario';

      // Verificar si el usuario ya existe en MongoDB
      final collection = MongoDBHelper.db.collection('users');
      final existingUser = await collection.findOne({'correo': email});

      if (existingUser == null) {
        // Si el usuario no existe, crearlo en MongoDB
        final newUser = UserModel(
          nombre: name,
          correo: email,
          contrasena: '', 
        );

        await collection.insert(newUser.toJson());
        print('Usuario creado en MongoDB: $name');
      } else {
        print('Usuario ya existe en MongoDB: $name');
      }

      // Navegar a la pantalla principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión con Google')),
      );
    }
  }

  Future<void> signOut() async {
    await GoogleAuthService.signOut();
    print('Sesión cerrada');
  }
}
