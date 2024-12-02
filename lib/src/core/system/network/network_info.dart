import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

sealed class NetworkCheckerSealed {
  Future<bool> get isConnected;
  Stream<InternetStatus> get onStatusChange;
}

class NetworkChecker implements NetworkCheckerSealed {
  NetworkChecker(this.connectionChecker);

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
