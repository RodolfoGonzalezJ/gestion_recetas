import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSwitch;
  final bool switchValue;
  final void Function(bool)? onChanged;
  final VoidCallback? onTap; // ✅ Nuevo parámetro

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.isSwitch = false,
    this.switchValue = false,
    this.onChanged,
    this.onTap, // ✅ Agregado al constructor
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final iconSize = size.width * 0.07;
    final verticalPadding = size.height * 0.012;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: verticalPadding,
        ),
        leading: Icon(icon, size: iconSize),
        title: Text(title),
        trailing:
            isSwitch
                ? Switch(value: switchValue, onChanged: onChanged)
                : Icon(Icons.arrow_forward_ios, size: iconSize * 0.7),
        onTap: isSwitch ? null : onTap, // ✅ Usar onTap si no es switch
      ),
    );
  }
}
