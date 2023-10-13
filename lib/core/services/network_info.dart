import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class NetworkInfo {
  /// Check if device is connected to network
  ///
  /// Returns [bool]
  Future<bool> get isConnected;
}

final class NetworkInfoImplementation implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  const NetworkInfoImplementation(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
