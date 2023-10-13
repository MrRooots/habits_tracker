import 'package:equatable/equatable.dart';

/// Base failures interface
abstract interface class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}

/// Internal server failures
final class ServerFailure extends Failure {
  const ServerFailure({required super.code, required super.message});
}

/// Connection failures
final class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.code, required super.message});
}

/// Authorization failures
final class AuthorizationFailure extends Failure {
  const AuthorizationFailure({required super.code, required super.message});
}

/// Authorization failures
final class RequestFailure extends Failure {
  const RequestFailure({required super.code, required super.message});
}

/// Cache failures
final class CacheFailure extends Failure {
  const CacheFailure({required super.code, required super.message});
}

/// Format failures
final class FormatFailure extends Failure {
  const FormatFailure({required super.code, required super.message});
}

/// Undefined failures
final class UndefinedFailure extends Failure {
  const UndefinedFailure({required super.code, required super.message});
}
