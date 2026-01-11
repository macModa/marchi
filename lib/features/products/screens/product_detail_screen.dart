import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/product_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../../shared/providers/cart_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Produit'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${ref.watch(cartProvider).itemCount}'),
              isLabelVisible: !ref.watch(cartProvider).isEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      body: productAsync.when(
        data: (product) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              CachedNetworkImage(
                imageUrl: AppConstants.placeholderImage,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.nom,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[900],
                                ),
                          ),
                        ),
                        Text(
                          '${product.prix.toStringAsFixed(2)} TND',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[700],
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(product.categoryNom ?? 'Catégorie'),
                      backgroundColor: Colors.brown[50],
                      labelStyle: TextStyle(color: Colors.brown[700]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? 'Aucune description disponible.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.storefront_outlined, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          'Artisan: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                        Text(
                          product.artisanNom ?? 'Inconnu',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.inventory_2_outlined, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          'Stock: ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
                        ),
                        Text(
                          '${product.stock} unités',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: product.stock > 0 ? Colors.green[700] : Colors.red[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Space for bottom button
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      bottomSheet: productAsync.whenOrNull(
        data: (product) => Container(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: product.stock > 0
                      ? () {
                          ref.read(cartProvider.notifier).addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ajouté au panier !')),
                          );
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text(
                    'Ajouter au Panier',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
