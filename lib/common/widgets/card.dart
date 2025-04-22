import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class IngredienteCard extends StatelessWidget {
  final String nombre;
  final String cantidad;
  final String unidad;
  final String imagen;

  const IngredienteCard({
    super.key,
    required this.nombre,
    required this.cantidad,
    required this.unidad,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final borderColor = dark ? Colors.grey.shade700 : Colors.grey.shade300;
    final textColor = dark ? Colors.white : CColors.primaryTextColor;
    final subTextColor = dark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = dark ? CColors.darkContainer : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              cantidad,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: AssetImage(imagen),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor,
                      ),
                    ),
                    Text(
                      unidad,
                      style: TextStyle(fontSize: 12, color: subTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
