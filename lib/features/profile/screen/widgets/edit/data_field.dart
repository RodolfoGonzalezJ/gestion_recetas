import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class DateField extends StatelessWidget {
  final String label;
  final String text;
  final VoidCallback onTap;

  const DateField({
    Key? key,
    required this.label,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: CColors.secondaryTextColor,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Expanded(
                  child: Text(text, style: const TextStyle(fontSize: 16)),
                ),
                const Icon(Icons.calendar_today, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
