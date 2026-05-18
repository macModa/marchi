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

class ProductListState {
  final List<ProductDto> products;
  final int page;
  final bool hasMore;
  final int? categoryId;
  final bool isLoading;
  final String? error;

  ProductListState({
    required this.products,
    required this.page,
    required this.hasMore,
    this.categoryId,
    required this.isLoading,
    this.error,
  });

  ProductListState.initial()
      : products = [],
        page = 0,
        hasMore = true,
        categoryId = null,
        isLoading = false,
        error = null;

  ProductListState copyWith({
    List<ProductDto>? products,
    int? page,
    bool? hasMore,
    int? categoryId,
    bool? isLoading,
    String? error,
  }) {
    return ProductListState(
      products: products ?? this.products,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      categoryId: categoryId ?? this.categoryId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProductListNotifier extends StateNotifier<ProductListState> {
  final ProductService _productService;

  ProductListNotifier(this._productService) : super(ProductListState.initial()) {
    loadProducts();
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (state.isLoading || (!state.hasMore && !refresh)) return;

    if (refresh) {
      state = state.copyWith(isLoading: true, products: [], page: 0, hasMore: true, error: null);
    } else {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      final response = await (state.categoryId == null
          ? _productService.getProducts(page: state.page, size: 20)
          : _productService.getProductsByCategory(state.categoryId!, page: state.page, size: 20));

      if (response.success && response.data != null) {
        final pagedData = response.data!;
        state = state.copyWith(
          products: [...state.products, ...pagedData.content],
          page: state.page + 1,
          hasMore: !pagedData.last,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false, error: response.message);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void setCategory(int? categoryId) {
    if (state.categoryId == categoryId) return;
    state = state.copyWith(categoryId: categoryId);
    loadProducts(refresh: true);
  }
}

final productListProvider = StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
  return ProductListNotifier(ref.watch(productServiceProvider));
});
