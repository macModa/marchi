import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_dto.dart';
import '../models/create_order_request.dart';
import '../services/order_service.dart';
import '../../../core/models/paged_response.dart';

final orderServiceProvider = Provider<OrderService>((ref) => OrderService());

final myOrdersProvider = FutureProvider.family<PagedResponse<OrderDto>, ({int page, int size})>((ref, arg) async {
  final service = ref.watch(orderServiceProvider);
  final response = await service.getMyOrders(page: arg.page, size: arg.size);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final orderDetailProvider = FutureProvider.family<OrderDto, int>((ref, id) async {
  final service = ref.watch(orderServiceProvider);
  final response = await service.getOrderById(id);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});

final createOrderProvider = FutureProvider.family<OrderDto, CreateOrderRequest>((ref, request) async {
  final service = ref.watch(orderServiceProvider);
  final response = await service.createOrder(request);
  if (response.success && response.data != null) {
    return response.data!;
  } else {
    throw response.message;
  }
});
