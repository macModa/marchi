import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/paged_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/order_dto.dart';
import '../models/create_order_request.dart';

class OrderService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<OrderDto>> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.orders,
        data: request.toJson(),
      );

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<OrderDto>> getOrderById(int id) async {
    try {
      final response = await _dioClient.get(ApiConstants.orderById(id));

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PagedResponse<OrderDto>>> getMyOrders({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.myOrders,
        queryParameters: {'page': page, 'size': size},
      );

      return ApiResponse<PagedResponse<OrderDto>>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PagedResponse<OrderDto>.fromJson(
          json as Map<String, dynamic>,
          (item) => OrderDto.fromJson(item as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<OrderDto>> cancelOrder(int id) async {
    try {
      final response = await _dioClient.put(ApiConstants.cancelOrder(id));

      return ApiResponse<OrderDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => OrderDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
