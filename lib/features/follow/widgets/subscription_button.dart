import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class StyledSubscriptionButton extends StatelessWidget {
  final Future<void> Function()? onPressed;
  final bool isSubscribed;
  final String priceText;

  const StyledSubscriptionButton({
    Key? key,
    required this.onPressed,
    this.isSubscribed = false,
    this.priceText = '\$ 40.000/mes',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 360;

    final buttonPadding =
        isSmall
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 14);

    final iconSize = isSmall ? 16.0 : 20.0;
    final fontSize = isSmall ? 14.0 : 16.0;
    final badgePadding =
        isSmall
            ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 6);

    return ElevatedButton(
      onPressed: isSubscribed ? null : () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: CColors.primaryButton,
        padding: buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.percent, color: Colors.white, size: iconSize),
          const SizedBox(width: 8),
          Text(
            isSubscribed ? 'Suscrito' : 'Suscribirse ($priceText)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: badgePadding,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              priceText,
              style: TextStyle(
                color: CColors.primaryButton,
                fontWeight: FontWeight.w600,
                fontSize: fontSize - 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
