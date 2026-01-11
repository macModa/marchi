import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import '../constants/api_constants.dart';
import 'package:logger/logger.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _storage;
  final Logger _logger = Logger();

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from secure storage
    final token = await _storage.getToken();

    if (token != null && token.isNotEmpty) {
      // Add JWT token to Authorization header
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix} $token';
      _logger.d('Added JWT token to request: ${options.path}');
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('Request error: ${err.response?.statusCode} - ${err.message}');

    // Handle 401 Unauthorized - Token expired or invalid
    if (err.response?.statusCode == 401) {
      _logger.w('Unauthorized access - clearing session');
      _storage.clearAll();
      // You can emit an event here to navigate to login screen
      // or use a global navigation key
    }

    // Handle 403 Forbidden - Insufficient permissions
    if (err.response?.statusCode == 403) {
      _logger.w('Forbidden access - insufficient permissions');
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('Response: ${response.statusCode} - ${response.requestOptions.path}');
    return handler.next(response);
  }
}
