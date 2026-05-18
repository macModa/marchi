import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marchi/shared/widgets/bon_livraison_pdf_button.dart';
import 'package:marchi/features/auth/providers/auth_providers.dart';
import 'package:marchi/features/orders/models/order_dto.dart';

/// Exemple d'intégration du bouton PDF dans une Card de commande (liste)
class OrderCardWithPdfExample extends ConsumerWidget {
  final OrderDTO order;
  final VoidCallback? onTap;

  const OrderCardWithPdfExample({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: onTap,
        title: Text(
          'Commande #${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Montant: \$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
            ),
            Text('Statut: ${order.statut ?? 'N/A'}'),
            Text('Date: ${order.createdAt ?? 'N/A'}'),
          ],
        ),
        trailing: authAsync.when(
          data: (auth) {
            if (auth?.token == null) {
              return const SizedBox.shrink();
            }
            return BonLivraisonPdfButtonCompact(
              orderId: order.id!,
              authToken: auth!.token,
              size: 28,
              onDownloadStart: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Téléchargement en cours...'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              onDownloadComplete: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('PDF ouvert ✅'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            );
          },
          loading: () => const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, _) => const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}

/// Exemple de page listant les commandes avec boutons PDF
class OrdersListWithPdfExample extends ConsumerWidget {
  final List<OrderDTO> orders;

  const OrdersListWithPdfExample({super.key, required this.orders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Commandes')),
      body: orders.isEmpty
          ? const Center(child: Text('Aucune commande'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCardWithPdfExample(
                  order: order,
                  onTap: () {
                    // Naviguer vers les détails de la commande
                    print('Détails commande #${order.id}');
                  },
                );
              },
            ),
    );
  }
}

/// Exemple d'intégration avancée avec Row de boutons d'action
class OrderCardWithActionButtons extends ConsumerWidget {
  final OrderDTO order;

  const OrderCardWithActionButtons({super.key, required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Infos de la commande ────────────────────────────────
            Text(
              'Commande #${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Montant: \$${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.statut),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    order.statut ?? 'N/A',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Boutons d'action ────────────────────────────────────
            authAsync.when(
              data: (auth) {
                if (auth?.token == null) {
                  return const SizedBox.shrink();
                }

                return Row(
                  children: [
                    // Bouton "Voir détails"
                    ElevatedButton.icon(
                      onPressed: () {
                        print('Détails commande #${order.id}');
                      },
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('Détails'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Bouton PDF
                    BonLivraisonPdfButton(
                      orderId: order.id!,
                      authToken: auth!.token,
                      fontSize: 12,
                      onDownloadStart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Préparation du PDF...'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 36,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              error: (_, _) => Text(
                'Erreur authentification',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toUpperCase()) {
      case 'DELIVERED':
        return Colors.green;
      case 'SHIPPED':
        return Colors.blue;
      case 'CONFIRMED':
        return Colors.orange;
      case 'PENDING':
        return Colors.grey;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
