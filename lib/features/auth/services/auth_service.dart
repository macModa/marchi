import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/models/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';
import '../models/register_request.dart';

class AuthService {
  final DioClient _dioClient = DioClient();

  Future<ApiResponse<AuthResponse>> login(AuthRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.authLogin,
        data: request.toJson(),
      );

      return ApiResponse<AuthResponse>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }

  Future<ApiResponse<AuthResponse>> register(RegisterRequest request) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.authRegister,
        data: request.toJson(),
      );

      return ApiResponse<AuthResponse>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => AuthResponse.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      throw ErrorHandler.handleException(e);
    }
  }
}
