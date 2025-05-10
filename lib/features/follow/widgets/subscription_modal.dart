import 'package:flutter/material.dart';

Future<void> showSubscriptionModal(
  BuildContext context,
  VoidCallback onConfirm,
) {
  return showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Quieres ver más?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ayuda al creador suscribiéndote y teniendo recetas únicas hechas por él, además sesiones virtuales y más beneficios.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                // style:
                child: const Text('Suscribirse'),
              ),
            ],
          ),
        ),
  );
}
