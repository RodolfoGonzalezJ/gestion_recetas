class UserProfile {
  final String username;
  final String name;
  final String bio;
  final String avatarUrl;
  final int recetas;
  final int vistas;
  final int seguidores;
  final int resenas;

  const UserProfile({
    required this.username,
    required this.name,
    required this.bio,
    required this.avatarUrl,
    required this.recetas,
    required this.vistas,
    required this.seguidores,
    required this.resenas,
  });
}
