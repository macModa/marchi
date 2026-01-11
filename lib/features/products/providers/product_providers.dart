import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_dto.dart';
import '../services/product_service.dart';
import 'product_service_provider.dart';
import '../../../core/models/paged_response.dart';

// No longer defining productServiceProvider here

final productsProvider = FutureProvider.family<PagedResponse<ProductDto>, ({int page, int size})>((ref, arg) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.getProducts(page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final availableProductsProvider = FutureProvider.family<PagedResponse<ProductDto>, ({int page, int size})>((ref, arg) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.getAvailableProducts(page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final productDetailProvider = FutureProvider.family<ProductDto, int>((ref, id) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.getProductById(id);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final productsByCategoryProvider = FutureProvider.family<PagedResponse<ProductDto>, ({int categoryId, int page, int size})>((ref, arg) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.getProductsByCategory(arg.categoryId, page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final productsByArtisanProvider = FutureProvider.family<PagedResponse<ProductDto>, ({int artisanId, int page, int size})>((ref, arg) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.getProductsByArtisan(arg.artisanId, page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final searchProductsProvider = FutureProvider.family<PagedResponse<ProductDto>, ({String keyword, int page, int size})>((ref, arg) async {
  final service = ref.watch(productServiceProvider);
  final response = await service.searchProducts(arg.keyword, page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});
