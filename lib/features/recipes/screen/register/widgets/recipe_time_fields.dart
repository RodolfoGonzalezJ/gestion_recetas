import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';

class RecipeTimeField extends StatelessWidget {
  final TextEditingController controller;

  const RecipeTimeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 0),
          initialEntryMode: TimePickerEntryMode.input,
          helpText: 'Duración de la receta',
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: dark ? CColors.dark : CColors.light,
                  hourMinuteTextColor:
                      dark ? CColors.light : CColors.secondaryTextColor,
                  hourMinuteColor:
                      dark ? Colors.grey.shade800 : Colors.grey.shade200,
                  helpTextStyle: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  entryModeIconColor:
                      Colors.transparent, // 👉 Ocultar el icono de cambiar modo
                ),
                colorScheme: ColorScheme.light(
                  primary: CColors.primaryColor,
                  onSurface: dark ? Colors.white : Colors.black,
                ).copyWith(surface: dark ? Colors.grey.shade900 : Colors.white),
              ),
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              ),
            );
          },
        );

        if (picked != null) {
          final formatted =
              "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
          controller.text = formatted;
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Duración (HH:MM) *',
            hintText: 'Ej: 01:30',
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Campo obligatorio';
            final regex = RegExp(r'^([0-9]{2}):([0-5][0-9])$');
            if (!regex.hasMatch(value)) return 'Formato inválido. Usa HH:MM';
            return null;
          },
        ),
      ),
    );
  }
}
