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
    };
  }
}
