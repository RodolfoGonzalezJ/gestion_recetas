import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/profile/models/user_profile_model.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class ProfileStats extends StatelessWidget {
  final UserProfile user;

  const ProfileStats({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? CColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat("Recetas", user.recetas.toString()),
          _buildStat("Vistas", '${user.vistas}k'),
          _buildStat("Seguidores", '${user.seguidores}k'),
          _buildStat("Reseñas", user.resenas.toString()),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
