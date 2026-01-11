import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/product_providers.dart';
import '../providers/product_service_provider.dart';
import '../models/product_dto.dart';
import '../../categories/providers/category_providers.dart';
import '../../../../core/constants/app_constants.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final int? productId;

  const ProductFormScreen({super.key, this.productId});

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prixController = TextEditingController();
  final _stockController = TextEditingController();
  int? _selectedCategoryId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      _loadProductData();
    }
  }

  Future<void> _loadProductData() async {
    // In a real app, you'd fetch the product details and populate the controllers
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une catégorie')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final product = ProductDto(
        id: widget.productId,
        nom: _nomController.text.trim(),
        description: _descriptionController.text.trim(),
        prix: double.parse(_prixController.text.trim()),
        stock: int.parse(_stockController.text.trim()),
        categoryId: _selectedCategoryId!,
        artisanId: 0, // Should be the current user's ID
      );

      bool success;
      if (widget.productId == null) {
        final response = await ref.read(productServiceProvider).createProduct(product);
        success = response.success;
      } else {
        final response = await ref.read(productServiceProvider).updateProduct(widget.productId!, product);
        success = response.success;
      }

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produit enregistré avec succès !')),
          );
          context.pop();
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
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productId == null ? 'Nouveau Produit' : 'Modifier Produit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom du produit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                ),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _prixController,
                      decoration: InputDecoration(
                        labelText: 'Prix (TND)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Champ requis';
                        if (double.tryParse(value) == null) return 'Prix invalide';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      decoration: InputDecoration(
                        labelText: 'Stock',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Champ requis';
                        if (int.tryParse(value) == null) return 'Stock invalide';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              categoriesAsync.when(
                data: (categories) => DropdownButtonFormField<int>(
                  value: _selectedCategoryId,
                  decoration: InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    ),
                  ),
                  items: categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.nom),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCategoryId = value),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Erreur catégories: $err'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _saveProduct,
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
                          'Enregistrer le Produit',
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
