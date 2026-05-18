import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../orders/models/order_dto.dart';
import '../../orders/services/order_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late Future<List<OrderDto>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // On récupère jusqu'à 1000 commandes pour les statistiques globales
    _ordersFuture = OrderService()
        .getAllOrdersAdmin(page: 0, size: 1000)
        .then((response) => response.data?.content ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: AppBar(
        backgroundColor: const Color(AppConstants.colorPrimary),
        foregroundColor: Colors.white,
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {
              _loadData();
            }),
          ),
        ],
      ),
      body: FutureBuilder<List<OrderDto>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          // Calcul des statistiques
          double totalRevenue = 0;
          int pendingCount = 0;
          int confirmedCount = 0;
          int shippedCount = 0;
          int deliveredCount = 0;
          int canceledCount = 0;

          for (final order in orders) {
            final statutName = order.statut.name.toUpperCase();
            if (statutName != 'CANCELLED') {
              totalRevenue += order.total;
            }

            switch (statutName) {
              case 'PENDING':
                pendingCount++;
                break;
              case 'CONFIRMED':
                confirmedCount++;
                break;
              case 'SHIPPED':
                shippedCount++;
                break;
              case 'DELIVERED':
                deliveredCount++;
                break;
              case 'CANCELLED':
                canceledCount++;
                break;
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vue d\'ensemble',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                
                // Carte Revenus
                _StatCard(
                  title: 'Revenus Totaux',
                  value: '${totalRevenue.toStringAsFixed(2)} TND',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),

                // Cartes de statut
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'En attente',
                        value: pendingCount.toString(),
                        icon: Icons.hourglass_empty,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Confirmées',
                        value: confirmedCount.toString(),
                        icon: Icons.check_circle_outline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Expédiées',
                        value: shippedCount.toString(),
                        icon: Icons.local_shipping_outlined,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Livrées',
                        value: deliveredCount.toString(),
                        icon: Icons.done_all,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _StatCard(
                  title: 'Annulées',
                  value: canceledCount.toString(),
                  icon: Icons.cancel_outlined,
                  color: Colors.red,
                ),
                
                const SizedBox(height: 32),

                // Navigation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.push('/admin/orders');
                    },
                    icon: const Icon(Icons.list_alt),
                    label: const Text('Gérer toutes les commandes'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(AppConstants.colorPrimary),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
