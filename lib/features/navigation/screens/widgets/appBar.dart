import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/navigation/screens/widgets/iconButtonBox.dart';

export 'appBar.dart';

Widget appBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
        child: iconButtonBox(imagePath: 'assets/logos/logo.png', onTap: () {}),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/logos/Ellipse 2.png'),
              ),
              SizedBox(width: 16),
              iconButtonBox(imagePath: 'assets/logos/Frame.png', onTap: () {}),
            ],
          ),
        ),
      ],
    ),
  );
}
