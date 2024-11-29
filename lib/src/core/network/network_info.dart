import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// lib/core/network/network_info.dart
abstract class NetworkChecker {
  Future<bool> get isConnected;
  Stream<InternetStatus> get onStatusChange;
}

class NetworkCheckerImpl implements NetworkChecker {
  NetworkCheckerImpl(this.connectionChecker);

  final InternetConnection connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;

  @override
  Stream<InternetStatus> get onStatusChange => connectionChecker.onStatusChange;
}

// void main() {
//   NetworkInfoImpl(InternetConnection.createInstance()).onStatusChange
//     .listen((onData) {
//       switch (onData) {
//         case InternetStatus.connected:
//           break;
//         case InternetStatus.disconnected:
//           break;
//       }
//     });
// }
