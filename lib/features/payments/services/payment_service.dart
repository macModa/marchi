import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/payment_dto.dart';
import '../models/create_payment_request.dart';

class PaymentService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<PaymentDto>> createPayment(int orderId, CreatePaymentRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.createPaymentForOrder(orderId),
        data: request.toJson(),
      );

      return ApiResponse<PaymentDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PaymentDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PaymentDto>> getPaymentByOrderId(int orderId) async {
    try {
      final response = await _dioClient.get(ApiConstants.paymentByOrder(orderId));

      return ApiResponse<PaymentDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PaymentDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<PaymentDto>> getPaymentById(int id) async {
    try {
      final response = await _dioClient.get(ApiConstants.paymentById(id));

      return ApiResponse<PaymentDto>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => PaymentDto.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
