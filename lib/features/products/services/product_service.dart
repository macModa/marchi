import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/paged_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/product_dto.dart';

class ProductService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<PagedResponse<ProductDto>>> getProducts({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.products,
        queryParameters: {'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<ProductDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<ProductDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => ProductDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<ProductDto>> getProductById(int id) async {
    try {
      final response = await _dioClient.get(ApiConstants.productById(id));

      return ApiResponse<ProductDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ProductDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<ProductDto>>> getProductsByCategory(
    int categoryId, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.productsByCategory(categoryId),
        queryParameters: {'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<ProductDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<ProductDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => ProductDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<ProductDto>>> getProductsByArtisan(
    int artisanId, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.productsByArtisan(artisanId),
        queryParameters: {'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<ProductDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<ProductDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => ProductDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<ProductDto>>> searchProducts(
    String keyword, {
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.productsSearch,
        queryParameters: {'keyword': keyword, 'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<ProductDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<ProductDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => ProductDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<ProductDto>>> getAvailableProducts({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.productsAvailable,
        queryParameters: {'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<ProductDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<ProductDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => ProductDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<ProductDto>> createProduct(ProductDto product) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.products,
        data: product.toJson(),
      );

      return ApiResponse<ProductDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ProductDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<ProductDto>> updateProduct(int id, ProductDto product) async {
    try {
      final response = await _dioClient.put(
        ApiConstants.productById(id),
        data: product.toJson(),
      );

      return ApiResponse<ProductDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => ProductDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<void>> deleteProduct(int id) async {
    try {
      final response = await _dioClient.delete(ApiConstants.productById(id));

      return ApiResponse<void>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => null,
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
