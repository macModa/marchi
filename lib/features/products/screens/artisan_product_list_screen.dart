import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_providers.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/product_card.dart';

class ArtisanProductListScreen extends ConsumerWidget {
  const ArtisanProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, you'd get the current user's ID
    // For now, let's assume we have a way to fetch the artisan's products
    // We already have productsByArtisanProvider
    
    // For the MVP, we'll just display all products but with management options
    // or fetch by a dummy artisan ID for now.
    final productsAsync = ref.watch(productsProvider((page: 0, size: 50)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Produits'),
      ),
      body: productsAsync.when(
        data: (pagedResponse) {
          final products = pagedResponse.content;
          if (products.isEmpty) {
            return const Center(child: Text('Vous n\'avez pas encore ajouté de produits.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_outlined),
                  ),
                  title: Text(product.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${product.prix.toStringAsFixed(2)} TND - Stock: ${product.stock}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () {
                          // Edit product
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Delete product
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/artisan/product/new'),
        backgroundColor: Colors.brown[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
