import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/order_providers.dart';
import '../../../../shared/widgets/order_card.dart';
import '../../../../core/constants/app_constants.dart';

class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(myOrdersProvider((page: 0, size: 20)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Commandes'),
      ),
      body: ordersAsync.when(
        data: (pagedResponse) {
          final orders = pagedResponse.content;
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('Vous n\'avez pas encore de commandes.'),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () => context.go('/home'),
                    style: FilledButton.styleFrom(backgroundColor: Colors.brown[700]),
                    child: const Text('Découvrir les produits'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: OrderCard(
                  order: orders[index],
                  onTap: () {
                    // Navigate to Order Details (future phase)
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
