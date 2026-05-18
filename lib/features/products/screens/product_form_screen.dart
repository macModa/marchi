import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/cloudinary_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../auth/providers/auth_providers.dart';
import '../../categories/providers/category_providers.dart';
import '../models/product_dto.dart';
import '../providers/product_providers.dart';
import '../providers/product_service_provider.dart';

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
  XFile? _selectedImage;
  Uint8List? _webImageBytes;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.productId != null) {
      _loadProductData();
    }
  }

  Future<void> _loadProductData() async {
    setState(() => _isLoading = true);
    try {
      final product = await ref.read(
        productDetailProvider(widget.productId!).future,
      );
      _nomController.text = product.nom;
      _descriptionController.text = product.description ?? '';
      _prixController.text = product.prix.toString();
      _stockController.text = product.stock.toString();
      _selectedCategoryId = product.categoryId;
      _imageUrl = product.imageUrl;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _descriptionController.dispose();
    _prixController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      Uint8List? webBytes;
      if (kIsWeb) {
        webBytes = await image.readAsBytes();
      }
      setState(() {
        _selectedImage = image;
        _webImageBytes = webBytes;
      });
    }
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
      final authData = ref.read(authStateProvider).value;
      if (authData == null) {
        throw 'Utilisateur non authentifié';
      }

      String? imageUrl = _imageUrl;

      // 1. Upload image FIRST if a new one is selected
      if (_selectedImage != null) {
        debugPrint('[ProductForm] Starting image upload...');
        debugPrint('[ProductForm] Image path: ${_selectedImage!.path}');
        debugPrint('[ProductForm] Image name: ${_selectedImage!.name}');

        if (kIsWeb) {
          final bytes = await _selectedImage!.readAsBytes();
          debugPrint('[ProductForm] Web image bytes length: ${bytes.length}');
          final uploadUrl = await CloudinaryService.uploadImageBytes(
            bytes,
            _selectedImage!.name,
          );
          debugPrint('[ProductForm] Cloudinary upload result: $uploadUrl');
          if (uploadUrl != null && uploadUrl.isNotEmpty) {
            imageUrl = uploadUrl;
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Échec de l'upload de l'image sur Cloudinary"),
                ),
              );
            }
            setState(() => _isLoading = false);
            return;
          }
        } else {
          final file = File(_selectedImage!.path);
          debugPrint('[ProductForm] Mobile file path: ${file.path}');
          debugPrint('[ProductForm] File exists: ${await file.exists()}');
          final uploadUrl = await CloudinaryService.uploadImage(file);
          debugPrint('[ProductForm] Cloudinary upload result: $uploadUrl');
          if (uploadUrl != null && uploadUrl.isNotEmpty) {
            imageUrl = uploadUrl;
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Échec de l'upload de l'image sur Cloudinary"),
                ),
              );
            }
            setState(() => _isLoading = false);
            return;
          }
        }

        debugPrint('[ProductForm] Final imageUrl after upload: $imageUrl');
      } else {
        debugPrint('[ProductForm] No new image selected, using existing: $imageUrl');
      }

      // 2. Create ProductDto WITH the imageUrl
      final product = ProductDto(
        id: widget.productId,
        nom: _nomController.text.trim(),
        description: _descriptionController.text.trim(),
        prix: double.parse(_prixController.text.trim()),
        stock: int.parse(_stockController.text.trim()),
        categoryId: _selectedCategoryId!,
        artisanId: authData.userId,
        imageUrl: imageUrl,
      );

      // Debug: Print the JSON payload being sent
      final payload = product.toJson();
      debugPrint('[ProductForm] Sending payload: ${jsonEncode(payload)}');
      debugPrint('[ProductForm] imageUrl in payload: ${payload['imageUrl']}');

      bool success;
      if (widget.productId == null) {
        final response = await ref
            .read(productServiceProvider)
            .createProduct(product);
        success = response.success;
        debugPrint('[ProductForm] Create response success: $success');
        debugPrint('[ProductForm] Create response data: ${response.data}');
      } else {
        final response = await ref
            .read(productServiceProvider)
            .updateProduct(widget.productId!, product);
        success = response.success;
        debugPrint('[ProductForm] Update response success: $success');
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
      debugPrint('[ProductForm] Error saving product: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
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
        title: Text(
          widget.productId == null ? 'Nouveau Produit' : 'Modifier Produit',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                      border: Border.all(color: Colors.brown.withOpacity(0.3)),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius,
                            ),
                            child: kIsWeb
                                ? (_webImageBytes != null
                                    ? Image.memory(
                                        _webImageBytes!,
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ))
                                : Image.file(
                                    File(_selectedImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                          )
                        : (_imageUrl != null && _imageUrl!.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius,
                            ),
                            child: Image.network(_imageUrl!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                size: 40,
                                color: Colors.brown[300],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ajouter une image',
                                style: TextStyle(
                                  color: Colors.brown[300],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom du produit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadius,
                    ),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadius,
                    ),
                  ),
                ),
                maxLines: 4,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
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
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Champ requis';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Prix invalide';
                        }
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
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Champ requis';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Stock invalide';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              categoriesAsync.when(
                data: (categories) => DropdownButtonFormField<int>(
                  initialValue: _selectedCategoryId,
                  decoration: InputDecoration(
                    labelText: 'Catégorie',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                  items: categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat.id,
                      child: Text(cat.nom),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCategoryId = value),
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
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Enregistrer le Produit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
