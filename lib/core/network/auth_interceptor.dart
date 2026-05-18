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
      // ✅ FIX: Use correct Bearer format for Spring Security
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix} $token';
      _logger.d('Added JWT token to request: ${options.path}');
      _logger.d('Full Authorization header: ${ApiConstants.bearerPrefix} $token');
    } else {
      _logger.w('No token found in secure storage for request: ${options.path}');
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('=== REQUEST ERROR ===');
    _logger.e('Path: ${err.requestOptions.path}');
    _logger.e('Method: ${err.requestOptions.method}');
    _logger.e('Status Code: ${err.response?.statusCode}');
    _logger.e('Status Message: ${err.response?.statusMessage}');
    _logger.e('Error Type: ${err.type}');
    _logger.e('Error Message: ${err.message}');
    
    // Log request headers for debugging
    _logger.e('Request Headers: ${err.requestOptions.headers}');
    
    // Log response body if available
    if (err.response?.data != null) {
      _logger.e('Response Data: ${err.response?.data}');
    }

    // Handle 401 Unauthorized - Token expired or invalid
    if (err.response?.statusCode == 401) {
      _logger.w('Unauthorized access (401) - clearing session');
      _storage.clearAll();
      // You can emit an event here to navigate to login screen
      // or use a global navigation key
    }

    // Handle 403 Forbidden - Insufficient permissions
    if (err.response?.statusCode == 403) {
      _logger.w('=== FORBIDDEN ACCESS (403) ===');
      _logger.w('Path: ${err.requestOptions.path}');
      _logger.w('This typically means:');
      _logger.w('  1. Token is valid but user role does not have permission');
      _logger.w('  2. CSRF or CORS issue');
      _logger.w('  3. Endpoint requires authentication but token was not sent');
      
      // Parse response for error details
      final responseData = err.response?.data;
      if (responseData != null) {
        _logger.w('Server error response: $responseData');
      }
    }

    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('Response: ${response.statusCode} - ${response.requestOptions.path}');
    if (response.statusCode == 403) {
      _logger.w('Response 403 received - checking headers...');
      _logger.d('Response headers: ${response.headers}');
      _logger.d('Response data: ${response.data}');
    }
    return handler.next(response);
  }
}
