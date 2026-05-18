import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marchi/features/auth/providers/auth_providers.dart';
import 'package:marchi/shared/widgets/bon_livraison_pdf_button.dart';
import 'package:marchi/features/orders/models/order_dto.dart';

/// Exemple d'intégration du bouton PDF dans une page de détails de commande
class OrderDetailsPageExample extends ConsumerWidget {
  final int orderId;
  final OrderDTO order;

  const OrderDetailsPageExample({
    super.key,
    required this.orderId,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Commande #$orderId')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Détails de la commande ────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Détails de la commande',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _DetailRow('ID:', '#$orderId'),
                    _DetailRow(
                      'Montant:',
                      '\$${order.totalAmount?.toStringAsFixed(2)}',
                    ),
                    _DetailRow('Statut:', order.statut ?? 'N/A'),
                    _DetailRow('Date:', order.createdAt ?? 'N/A'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ── Bouton de téléchargement PDF ────────────────────────────
            authAsync.when(
              data: (auth) {
                if (auth == null) {
                  return Center(
                    child: Text(
                      'Non authentifié',
                      style: TextStyle(color: Colors.red.shade600),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bon de livraison',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    BonLivraisonPdfButton(
                      orderId: orderId,
                      authToken: auth.token,
                      onDownloadStart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Préparation du PDF...'),
                          ),
                        );
                      },
                      onDownloadComplete: () {
                        // Optionnel : rafraîchir les données, etc.
                        print('PDF téléchargé pour commande #$orderId');
                      },
                      onError: (error) {
                        print('Erreur PDF: $error');
                      },
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Erreur: $error')),
            ),
            const SizedBox(height: 24),

            // ── Exemple avec bouton compact ────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Text('Actions rapides:'),
                    const Spacer(),
                    authAsync.when(
                      data: (auth) {
                        if (auth?.token != null) {
                          return BonLivraisonPdfButtonCompact(
                            orderId: orderId,
                            authToken: auth!.token,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      loading: () => const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      error: (_, _) => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget helper pour afficher les détails
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
