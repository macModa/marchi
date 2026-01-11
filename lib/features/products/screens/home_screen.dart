import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_providers.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../../shared/widgets/product_card.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/providers/cart_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider((page: 0, size: 20)));
    final userRole = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: Badge(
              label: Text('${ref.watch(cartProvider).itemCount}'),
              isLabelVisible: !ref.watch(cartProvider).isEmpty,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () => context.push('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authStateProvider.notifier).logout(),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown[700]),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.brown),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Mon Compte',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_outlined),
              title: const Text('Mes Commandes'),
              onTap: () {
                Navigator.pop(context);
                context.push('/orders');
              },
            ),
            if (userRole == AppConstants.roleArtisan)
              ListTile(
                leading: const Icon(Icons.storefront),
                title: const Text('Ma Boutique'),
                onTap: () {
                  Navigator.pop(context);
                  context.push('/artisan/products');
                },
              ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                ref.read(authStateProvider.notifier).logout();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      body: productsAsync.when(
        data: (pagedResponse) {
          final products = pagedResponse.content;
          if (products.isEmpty) {
            return const Center(child: Text('Aucun produit disponible.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: products[index],
                onTap: () => context.push('/product/${products[index].id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Erreur: $err'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(productsProvider((page: 0, size: 20))),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: userRole == AppConstants.roleArtisan
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/artisan/product/new'),
              label: const Text('Nouveau Produit'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.brown[700],
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}
