/// Base exceptions interface
abstract interface class BaseException implements Exception {
  final int code;
  final String message;

  const BaseException({required this.code, required this.message});
}

/// Internal server exceptions
final class ServerException extends BaseException {
  const ServerException({required super.code, required super.message});
}

/// Connection exceptions
final class ConnectionException extends BaseException {
  const ConnectionException({required super.code, required super.message});
}

/// Authorization exceptions
final class AuthorizationException extends BaseException {
  const AuthorizationException({required super.code, required super.message});
}

/// Authorization exceptions
final class RequestException extends BaseException {
  const RequestException({required super.code, required super.message});
}

/// Cache exceptions caused by database
final class CacheException extends BaseException {
  const CacheException({required super.code, required super.message});
}

/// Cache exceptions caused by database
final class FormatException extends BaseException {
  const FormatException({required super.code, required super.message});
}

/// Undefined exceptions
final class UndefinedException extends BaseException {
  const UndefinedException({required super.code, required super.message});
}
