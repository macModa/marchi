import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_dto.dart';
import '../services/category_service.dart';

final categoryServiceProvider = Provider<CategoryService>((ref) => CategoryService());

final categoriesProvider = FutureProvider<List<CategoryDto>>((ref) async {
  final service = ref.watch(categoryServiceProvider);
  final response = await service.getCategories();
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final categoryDetailProvider = FutureProvider.family<CategoryDto, int>((ref, id) async {
  final service = ref.watch(categoryServiceProvider);
  final response = await service.getCategoryById(id);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});
