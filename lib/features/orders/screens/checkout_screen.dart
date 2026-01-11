import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/cart_provider.dart';
import '../providers/order_providers.dart';
import '../models/create_order_request.dart';
import '../../../../core/constants/app_constants.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _isLoading = false;

  Future<void> _placeOrder() async {
    final cart = ref.read(cartProvider);
    if (cart.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final orderLines = cart.items
          .map((item) => OrderLineRequest(
                productId: item.product.id!,
                quantite: item.quantity,
              ))
          .toList();

      final request = CreateOrderRequest(orderLines: orderLines);
      
      final response = await ref.read(orderServiceProvider).createOrder(request);

      if (response.success && response.data != null) {
        // Clear cart after successful order
        ref.read(cartProvider.notifier).clearCart();
        
        // Navigate to payment screen with order ID
        if (mounted) {
          context.pushReplacement('/payment/${response.data!.id}');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Validation de commande'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Récapitulatif',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.items.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
                    title: Text(item.product.nom),
                    subtitle: Text('Quantité: ${item.quantity}'),
                    trailing: Text('${item.subtotal.toStringAsFixed(2)} TND'),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sous-total', style: TextStyle(fontSize: 16)),
                Text('${cart.total.toStringAsFixed(2)} TND', style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Frais de livraison', style: TextStyle(fontSize: 16)),
                Text('Gratuit', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total à payer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${cart.total.toStringAsFixed(2)} TND',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isLoading ? null : _placeOrder,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.brown[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Confirmer la commande',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
