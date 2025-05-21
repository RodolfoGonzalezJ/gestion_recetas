import 'package:flutter/material.dart';
import 'package:gestion_recetas/features/inventory/models/models.dart';
import 'dart:io';

class ProductDetailExpiringScreen extends StatelessWidget {
  final Product product;

  const ProductDetailExpiringScreen({Key? key, required this.product})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysToExpire = product.expiryDate.difference(DateTime.now()).inDays;
    final status =
        daysToExpire < 0
            ? 'Vencido'
            : daysToExpire == 0
            ? 'Hoy'
            : 'Expira en $daysToExpire días';

    final statusColor = _getExpirationColor(status);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        backgroundColor: statusColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 500;
          return SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Imagen destacada
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: statusColor.withOpacity(0.18),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: _buildImage(product.photoUrl),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Nombre y estado
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF22223B),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Tarjetas de información
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _infoCard(
                          icon: Icons.category,
                          label: 'Categoría',
                          value: product.category,
                        ),
                        _infoCard(
                          icon: Icons.inventory_2,
                          label: 'Cantidad',
                          value: '${product.quantity}',
                        ),
                        if (product.grams != null)
                          _infoCard(
                            icon: Icons.scale,
                            label: 'Gramos',
                            value: '${product.grams}',
                          ),
                        _infoCard(
                          icon: Icons.calendar_today,
                          label: 'Ingreso',
                          value: _formatDate(product.entryDate),
                        ),
                        _infoCard(
                          icon: Icons.event,
                          label: 'Expira',
                          value: _formatDate(product.expiryDate),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Notas
                    if (product.notes != null && product.notes!.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.yellow[50],
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.yellow[700]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.sticky_note_2,
                              color: Colors.amber,
                              size: 22,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                product.notes!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF444444),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blueGrey[700], size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF6C757D),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF22223B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Image.asset(
        'assets/images/1.png',
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/1.png',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/1.png',
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Color _getExpirationColor(String status) {
    if (status.contains('Vencido')) {
      return Colors.red;
    } else if (status.contains('Hoy')) {
      return Colors.orange;
    } else if (status.contains('Expira en')) {
      return Colors.green;
    }
    return Colors.grey;
  }
}
