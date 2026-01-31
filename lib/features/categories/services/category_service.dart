import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/category_dto.dart';

class CategoryService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<List<CategoryDto>>> getCategories() async {
    try {
      final response = await _dioClient.get(ApiConstants.categories);

      return ApiResponse<List<CategoryDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => (json as List<dynamic>)
            .map((item) => CategoryDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<CategoryDto>> getCategoryById(int id) async {
    try {
      final response = await _dioClient.get(ApiConstants.categoryById(id));

      return ApiResponse<CategoryDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CategoryDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<CategoryDto>> createCategory(CategoryDto category) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.categories,
        data: category.toJson(),
      );

      return ApiResponse<CategoryDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => CategoryDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
