import 'package:dio/dio.dart';

/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  NetworkException(super.message, {super.code, super.details});
}

/// Authentication exceptions
class AuthException extends AppException {
  AuthException(super.message, {super.code, super.details});
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException(super.message, {super.code, super.details});
}

/// Not found exceptions
class NotFoundException extends AppException {
  NotFoundException(super.message, {super.code, super.details});
}

/// Server exceptions
class ServerException extends AppException {
  ServerException(super.message, {super.code, super.details});
}

/// Unauthorized exceptions
class UnauthorizedException extends AppException {
  UnauthorizedException(super.message, {super.code, super.details});
}

/// Forbidden exceptions
class ForbiddenException extends AppException {
  ForbiddenException(super.message, {super.code, super.details});
}

/// Timeout exceptions
class TimeoutException extends AppException {
  TimeoutException(super.message, {super.code, super.details});
}

/// Unknown exceptions
class UnknownException extends AppException {
  UnknownException(super.message, {super.code, super.details});
}
