import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';

class ProfileStats extends StatelessWidget {
  final UserProfile user;
  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStat("Recetas", user.recetas.toString(), textStyle),
        _buildStat("Vistas", '${user.vistas}k', textStyle),
        _buildStat("Seguidores", '${user.seguidores}k', textStyle),
        _buildStat("Reseñas", user.resenas.toString(), textStyle),
      ],
    );
  }

  Widget _buildStat(String label, String value, TextStyle? style) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: style),
      ],
    );
  }
}
