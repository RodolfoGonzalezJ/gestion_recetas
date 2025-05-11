class UserModel {
  String? nombre;
  String? apellido;
  String? celular;
  String? cedula;
  DateTime? fechaNacimiento;
  String? correo;
  String? pais;
  String? departamento;
  String? municipio;
  String? direccion;
  String? barrio;
  String? contrasena;
  String? bio; 
  String? avatarUrl;

  UserModel({
    this.nombre,
    this.apellido,
    this.celular,
    this.cedula,
    this.fechaNacimiento,
    this.correo,
    this.pais,
    this.departamento,
    this.municipio,
    this.direccion,
    this.barrio,
    this.contrasena,
    this.bio,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'cedula': cedula,
      'fechaNacimiento': fechaNacimiento?.toIso8601String(),
      'correo': correo,
      'pais': pais,
      'departamento': departamento,
      'municipio': municipio,
      'direccion': direccion,
      'barrio': barrio,
      'contrasena': contrasena,
      'bio': bio,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nombre: json['nombre'],
      apellido: json['apellido'],
      celular: json['celular'],
      cedula: json['cedula'],
      fechaNacimiento:
          json['fechaNacimiento'] != null
              ? DateTime.parse(json['fechaNacimiento'])
              : null,
      correo: json['correo'],
      pais: json['pais'],
      departamento: json['departamento'],
      municipio: json['municipio'],
      direccion: json['direccion'],
      barrio: json['barrio'],
      contrasena: json['contrasena'],
      bio: json['bio'],
      avatarUrl: json['avatarUrl'],
    );
  }

  UserModel copyWith({
    String? nombre,
    String? apellido,
    String? celular,
    String? cedula,
    DateTime? fechaNacimiento,
    String? correo,
    String? pais,
    String? departamento,
    String? municipio,
    String? direccion,
    String? barrio,
    String? contrasena,
    String? bio,
    String? avatarUrl,
  }) {
    return UserModel(
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      celular: celular ?? this.celular,
      cedula: cedula ?? this.cedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      correo: correo ?? this.correo,
      pais: pais ?? this.pais,
      departamento: departamento ?? this.departamento,
      municipio: municipio ?? this.municipio,
      direccion: direccion ?? this.direccion,
      barrio: barrio ?? this.barrio,
      contrasena: contrasena ?? this.contrasena,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
