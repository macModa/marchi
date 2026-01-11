import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'app_exception.dart';
import '../constants/app_constants.dart';

class ErrorHandler {
  static final Logger _logger = Logger();

  /// Handle Dio exceptions and convert to AppException
  static AppException handleDioError(DioException error) {
    _logger.e('Dio Error: ${error.type} - ${error.message}');

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          'Délai d\'attente dépassé. Veuillez réessayer.',
          code: 'TIMEOUT',
          details: error,
        );

      case DioExceptionType.badResponse:
        return _handleResponseError(error);

      case DioExceptionType.cancel:
        return NetworkException(
          'Requête annulée.',
          code: 'CANCELLED',
          details: error,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          AppConstants.errorNetwork,
          code: 'CONNECTION_ERROR',
          details: error,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          'Certificat SSL invalide.',
          code: 'BAD_CERTIFICATE',
          details: error,
        );

      case DioExceptionType.unknown:
      default:
        return NetworkException(
          AppConstants.errorGeneric,
          code: 'UNKNOWN',
          details: error,
        );
    }
  }

  /// Handle HTTP response errors
  static AppException _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Try to extract error message from ApiResponse
    String message = AppConstants.errorGeneric;
    if (data is Map<String, dynamic>) {
      message = data['message'] as String? ?? message;
    }

    switch (statusCode) {
      case 400:
        return ValidationException(
          message,
          code: 'BAD_REQUEST',
          details: data,
        );

      case 401:
        return UnauthorizedException(
          AppConstants.errorAuth,
          code: 'UNAUTHORIZED',
          details: data,
        );

      case 403:
        return ForbiddenException(
          'Accès refusé. Vous n\'avez pas les permissions nécessaires.',
          code: 'FORBIDDEN',
          details: data,
        );

      case 404:
        return NotFoundException(
          AppConstants.errorNotFound,
          code: 'NOT_FOUND',
          details: data,
        );

      case 409:
        return ValidationException(
          message,
          code: 'CONFLICT',
          details: data,
        );

      case 422:
        return ValidationException(
          message,
          code: 'UNPROCESSABLE_ENTITY',
          details: data,
        );

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          'Erreur serveur. Veuillez réessayer plus tard.',
          code: 'SERVER_ERROR',
          details: data,
        );

      default:
        return UnknownException(
          message,
          code: 'HTTP_$statusCode',
          details: data,
        );
    }
  }

  /// Handle generic exceptions
  static AppException handleException(Object error) {
    _logger.e('Generic Error: $error');

    if (error is AppException) {
      return error;
    }

    if (error is DioException) {
      return handleDioError(error);
    }

    return UnknownException(
      AppConstants.errorGeneric,
      code: 'UNKNOWN',
      details: error,
    );
  }

  /// Get user-friendly error message
  static String getUserMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }

    if (error is DioException) {
      return handleDioError(error).message;
    }

    return AppConstants.errorGeneric;
  }
}
