import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class VerTodasButton extends StatelessWidget {
  final VoidCallback onTap;

  const VerTodasButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Todas mis recetas", style: theme.textTheme.bodyMedium),
            const Icon(Iconsax.arrow_right_3),
          ],
        ),
      ),
    );
  }
}
