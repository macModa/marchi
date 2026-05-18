import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/products/models/product_dto.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/providers/auth_providers.dart';
import '../../features/products/providers/product_service_provider.dart';

class ProductCard extends ConsumerWidget {
  final ProductDto product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  /// Builds the product image with null safety
  /// Shows product imageUrl if available, otherwise shows placeholder
  Widget _buildProductImage() {
    // ✅ Use product imageUrl if available and not empty
    final hasValidImageUrl =
        product.imageUrl != null && product.imageUrl!.isNotEmpty;

    if (hasValidImageUrl) {
      return CachedNetworkImage(
        imageUrl: product.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: const Color(AppConstants.colorBackground),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    }

    return _buildPlaceholder();
  }

  /// Shows placeholder when no image is available
  Widget _buildPlaceholder() {
    return Container(
      color: const Color(AppConstants.colorBackground),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: Color(AppConstants.colorSecondary),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final isOwner =
        user != null &&
        product.artisanId != null &&
        user.userId == product.artisanId;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: BorderSide(color: Colors.black.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ✅ Show product image if available, else show placeholder
                  _buildProductImage(),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isOwner
                            ? Icons.edit_rounded
                            : Icons.add_shopping_cart_rounded,
                        size: 16,
                        color: const Color(AppConstants.colorSecondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.nom,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(AppConstants.colorTextPrimary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.categoryNom ?? 'Artisanat',
                          style: TextStyle(
                            color: const Color(AppConstants.colorTextSecondary),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        '${product.prix.toStringAsFixed(1)} TND',
                        style: TextStyle(
                          color: const Color(AppConstants.colorPrimary),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, int productId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Supprimer"),
        content: const Text("Voulez-vous supprimer ce produit ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog first
              try {
                final response = await ref
                    .read(productServiceProvider)
                    .deleteProduct(productId);
                if (response.success) {
                  // Invalidate logic should be handled by parent or by listening to provider changes
                  // But here we might want to refresh list.
                  // Since we are in a card, we can't easily instruct parent to refresh unless we use a provider for the list.
                  // For now, simple feedback.
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Produit supprimé')),
                    );
                    // Force refresh usage:
                    // ref.invalidate(productsProvider); // assuming there is one
                  }
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
                }
              }
            },
            child: const Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
