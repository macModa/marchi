import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_dto.dart';
import '../services/product_service.dart';
import 'product_service_provider.dart';

final productSearchProvider = FutureProvider.family<List<ProductDto>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final service = ref.read(productServiceProvider);
  final response = await service.searchProducts(query);
  if (response.success && response.data != null) {
    return response.data!.content; // PagedResponse has a content field usually
  } else {
    throw response.message;
  }
});
