import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_providers.dart';
import '../providers/product_service_provider.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../../core/constants/app_constants.dart';

class ArtisanProductListScreen extends ConsumerWidget {
  const ArtisanProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authStateProvider).value;
    final artisanId = authData?.userId;

    if (artisanId == null) {
      return const Scaffold(
        body: Center(child: Text('Erreur: Utilisateur non trouvé.')),
      );
    }

    final productsAsync = ref.watch(
      productsByArtisanProvider((artisanId: artisanId, page: 0, size: 50)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Produits')),
      body: productsAsync.when(
        data: (pagedResponse) {
          final products = pagedResponse.content;
          if (products.isEmpty) {
            return const Center(
              child: Text('Vous n\'avez pas encore ajouté de produits.'),
            );
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
                  title: Text(
                    product.nom,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${product.prix.toStringAsFixed(2)} TND - Stock: ${product.stock}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit_outlined,
                          color: Colors.blue,
                        ),
                        onPressed: () =>
                            context.push('/artisan/product/edit/${product.id}'),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Supprimer le produit'),
                              content: const Text(
                                'Êtes-vous sûr de vouloir supprimer ce produit ?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text(
                                    'Supprimer',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirmed == true) {
                            try {
                              final response = await ref
                                  .read(productServiceProvider)
                                  .deleteProduct(product.id!);
                              if (response.success) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Produit supprimé'),
                                    ),
                                  );
                                  ref.invalidate(productsByArtisanProvider);
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Erreur: $e')),
                                );
                              }
                            }
                          }
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
