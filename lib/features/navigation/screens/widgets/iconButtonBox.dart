import 'dart:ui';
import 'package:flutter/material.dart';

export 'iconButtonBox.dart';

Widget iconButtonBox({
  IconData? icon,
  String? imagePath,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          imagePath != null
              ? Image.asset(imagePath, width: 28, height: 28)
              : Icon(icon, color: Colors.green, size: 24),
    ),
  );
}
