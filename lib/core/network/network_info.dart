import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  NetworkInfoImpl({required this.connectionChecker}) {
    // connectionChecker.addresses = [];
  }
  @override
  Future<bool> get isConnected =>
      Future.delayed(const Duration(milliseconds: 50), () => true);
  // @override
  // Future<bool> get isConnected => connectionChecker.hasConnection;
}
