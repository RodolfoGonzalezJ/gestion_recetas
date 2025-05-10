import 'package:flutter/material.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';

class SubscriptionButton extends StatelessWidget {
  final bool isSubscribed;
  final VoidCallback onSubscribe;

  const SubscriptionButton({
    super.key,
    required this.isSubscribed,
    required this.onSubscribe,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onSubscribe,
      icon: Icon(
        isSubscribed ? Icons.check_circle : Icons.lock_open,
        color: CColors.light,
      ),
      label: Text(
        isSubscribed ? 'Suscrito' : 'Suscribirse',
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSubscribed ? CColors.textCategory : CColors.primaryButton,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
