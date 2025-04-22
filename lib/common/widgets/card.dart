import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'package:gestion_recetas/utils/theme/custom_themes/text_field_theme.dart';

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

    // Inspirado en el TextFieldTheme
    final borderColor = CColors.borderPrimary;
    final textColor = dark ? CColors.textBlanco : CColors.primaryTextColor;
    final subTextColor = dark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor =
        dark
            ? TTextFieldTheme.darkInputDecorationTheme.fillColor
            : TTextFieldTheme.lightInputDecorationTheme.fillColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: dark ? Colors.black26 : Colors.grey.shade100,
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
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(imagen),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }
}
