import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/follow/widgets/subscription_button.dart';
import 'package:gestion_recetas/utils/constants/colors.dart';
import 'package:gestion_recetas/features/follow/services/pay_service.dart';
import 'package:gestion_recetas/features/auth/controllers/controllers.dart'; // Asegúrate de importar tu AuthController

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = AuthController(); // Instancia tu controlador

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suscripción'),
        backgroundColor: CColors.primaryButton,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suscríbete por solo',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '\$ 40.000/mes',
              style: theme.textTheme.displaySmall?.copyWith(
                color: CColors.primaryButton,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Ventajas de la suscripción',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildAdvantage('Acceso a recetas exclusivas'),
            _buildAdvantage('Sesiones virtuales con el chef'),
            _buildAdvantage('Descuentos en eventos y talleres'),
            _buildAdvantage('Soporte prioritario'),
            const Spacer(),
            Center(
              child: StyledSubscriptionButton(
                onPressed: () async {
                  final pagoExitoso = await PayService.simulatePayment(context);
                  if (pagoExitoso) {
                    await authController.updateStatus("SUSCRITO"); // <-- Aquí actualizas el estado
                    Navigator.pop(context, true); // Retorna true si se suscribió
                  }
                },
                isSubscribed: false,
                priceText: '\$ 40.000/mes',
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvantage(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: CColors.primaryButton, size: 22),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}