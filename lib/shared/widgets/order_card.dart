import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../features/orders/models/order_dto.dart';
import '../../features/orders/models/order_status.dart';
import '../../core/constants/app_constants.dart';

class OrderCard extends StatelessWidget {
  final OrderDto order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commande #${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _StatusBadge(status: order.statut),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${order.dateCreation}', // You might want to format this with intl
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.orderLines.length} article(s)',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${order.total.toStringAsFixed(2)} TND',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case OrderStatus.en_attente:
        color = Colors.orange;
        label = 'En attente';
        break;
      case OrderStatus.confirmee:
        color = Colors.blue;
        label = 'Confirmée';
        break;
      case OrderStatus.en_cours:
        color = Colors.indigo;
        label = 'En cours';
        break;
      case OrderStatus.expediee:
        color = Colors.purple;
        label = 'Expédiée';
        break;
      case OrderStatus.livree:
        color = Colors.green;
        label = 'Livrée';
        break;
      case OrderStatus.annulee:
        color = Colors.red;
        label = 'Annulée';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
