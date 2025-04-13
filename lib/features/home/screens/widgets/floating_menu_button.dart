import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/utils/helpers/helper_functions.dart';
import 'blurred_background.dart';
import 'animated_action_item.dart';

class FloatingMenuButton extends StatefulWidget {
  const FloatingMenuButton({super.key});

  @override
  State<FloatingMenuButton> createState() => _FloatingMenuButtonState();
}

class _FloatingMenuButtonState extends State<FloatingMenuButton> {
  bool isOpen = false;
  List<bool> showButtons = [false, false];

  void toggleMenu() async {
    if (isOpen) {
      setState(() => showButtons = [false, false]);
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => isOpen = false);
    } else {
      setState(() => isOpen = true);
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() => showButtons[0] = true);
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() => showButtons[1] = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = THelperFunctions.isDarkMode(context);
    final Color backgroundColor = isDark ? CColors.dark : CColors.primaryColor;
    final Color iconColor = Colors.white;

    return Stack(
      children: [
        if (isOpen) BlurredBackground(onTap: toggleMenu),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedActionItem(
                visible: showButtons[0],
                label: "Registrar Receta",
                icon: Icons.food_bank,
                color: backgroundColor,
                onPressed: toggleMenu,
              ),
              const SizedBox(height: 12),
              AnimatedActionItem(
                visible: showButtons[1],
                label: "Registrar Producto",
                icon: Icons.add_shopping_cart,

                color: backgroundColor,
                onPressed: toggleMenu,
              ),
              const SizedBox(height: 12),
              FloatingActionButton(
                onPressed: toggleMenu,
                backgroundColor: backgroundColor,
                child: Icon(isOpen ? Icons.close : Icons.add, color: iconColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
