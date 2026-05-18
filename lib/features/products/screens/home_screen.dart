import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_providers.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../../shared/widgets/product_card.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/providers/cart_provider.dart';
import '../../categories/providers/category_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(productListProvider.notifier).loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final userRole = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              color: const Color(AppConstants.colorTextPrimary),
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
            children: [
              const TextSpan(text: "m'"),
              TextSpan(
                text: "art",
                style: TextStyle(
                  color: const Color(AppConstants.colorPrimary),
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Cursive',
                ),
              ),
              const TextSpan(text: "Chez"),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => context.push('/search'),
          ),
          IconButton(
            icon: Badge(
              label: Text('${ref.watch(cartProvider).itemCount}'),
              isLabelVisible: !ref.watch(cartProvider).isEmpty,
              backgroundColor: const Color(AppConstants.colorPrimary),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(AppConstants.colorBackground),
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(AppConstants.colorBackground),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xFFF5EEE6),
                        child: Icon(
                          Icons.person_outline_rounded,
                          size: 35,
                          color: Color(AppConstants.colorTextPrimary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Mon Compte',
                      style: TextStyle(
                        color: Color(AppConstants.colorTextPrimary),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(
              icon: Icons.home_outlined,
              title: 'Accueil',
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              icon: Icons.assignment_outlined,
              title: 'Mes Commandes',
              onTap: () {
                Navigator.pop(context);
                context.push('/orders');
              },
            ),
            if (userRole == AppConstants.roleArtisan)
              _buildDrawerItem(
                icon: Icons.storefront_outlined,
                title: 'Ma Boutique',
                onTap: () {
                  Navigator.pop(context);
                  context.push('/artisan/products');
                },
              ),
            if (userRole == AppConstants.roleAdmin)
              _buildDrawerItem(
                icon: Icons.category_outlined,
                title: 'Gérer les Catégories',
                onTap: () {
                  Navigator.pop(context);
                  context.push('/admin/category/new');
                },
              ),
            const Spacer(),
            const Divider(indent: 20, endIndent: 20),
            _buildDrawerItem(
              icon: Icons.logout_rounded,
              title: 'Déconnexion',
              color: Colors.red[400],
              onTap: () {
                Navigator.pop(context);
                ref.read(authStateProvider.notifier).logout();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category Filter
          categoriesAsync.when(
            data: (categories) => Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length + 1,
                itemBuilder: (context, index) {
                  final isAll = index == 0;
                  final category = isAll ? null : categories[index - 1];
                  final isSelected = productState.categoryId == category?.id;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChip(
                      label: Text(isAll ? 'Tout' : category!.nom),
                      selected: isSelected,
                      onSelected: (_) => ref
                          .read(productListProvider.notifier)
                          .setCategory(category?.id),
                      backgroundColor: Colors.white,
                      selectedColor: const Color(
                        AppConstants.colorSecondary,
                      ).withOpacity(0.2),
                      checkmarkColor: const Color(AppConstants.colorSecondary),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(AppConstants.colorSecondary)
                            : Colors.transparent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(AppConstants.colorTextPrimary)
                            : const Color(AppConstants.colorTextSecondary),
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            loading: () => const SizedBox(
              height: 60,
              child: Center(child: LinearProgressIndicator()),
            ),
            error: (err, stack) => const SizedBox.shrink(),          ),

          // Products Grid
          Expanded(
            child: RefreshIndicator(
              color: const Color(AppConstants.colorPrimary),
              onRefresh: () => ref
                  .read(productListProvider.notifier)
                  .loadProducts(refresh: true),
              child: productState.products.isEmpty && !productState.isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun produit disponible.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(
                        AppConstants.defaultPadding,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      itemCount:
                          productState.products.length +
                          (productState.isLoading ? 2 : 0),
                      itemBuilder: (context, index) {
                        if (index < productState.products.length) {
                          return ProductCard(
                            product: productState.products[index],
                            onTap: () => context.push(
                              '/product/${productState.products[index].id}',
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ),
          ),
          if (productState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Erreur: ${productState.error}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      floatingActionButton: _buildFab(context, userRole),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? const Color(AppConstants.colorTextPrimary),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? const Color(AppConstants.colorTextPrimary),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  Widget? _buildFab(BuildContext context, String? userRole) {
    if (userRole == AppConstants.roleArtisan) {
      return FloatingActionButton.extended(
        onPressed: () => context.push('/artisan/product/new'),
        label: const Text('Nouveau Produit'),
        icon: const Icon(Icons.add),
        elevation: 2,
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      );
    } else if (userRole == AppConstants.roleAdmin) {
      return FloatingActionButton.extended(
        onPressed: () => context.push('/admin/category/new'),
        label: const Text('Nouvelle Catégorie'),
        icon: const Icon(Icons.category),
        elevation: 2,
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      );
    }
    return null;
  }
}
