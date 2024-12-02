import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:rh_host/src/core/system/network/network_info.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityService({
    NetworkCheckerSealed? networkChecker,
  }) : _networkChecker = networkChecker ??
            NetworkChecker(
              InternetConnection.createInstance(),
            ) {
    _initialize();
  }

  final NetworkCheckerSealed _networkChecker;
  bool _hasConnection = true;
  DateTime? _lastOfflineTime;
  int _consecutiveFailures = 0;
  Timer? _pingTimer;

  bool get hasConnection => _hasConnection;

  bool get isOffline => !_hasConnection;

  Duration? get offlineDuration =>
      _lastOfflineTime != null ? DateTime.now().difference(_lastOfflineTime!) : null;

  Future<void> _initialize() async {
    // Listen to platform connectivity changes
    _networkChecker.onStatusChange.listen(_handleConnectivityChange);

    // Start periodic validation
    _startPeriodicCheck();
  }

  Future<void> _handleConnectivityChange(InternetStatus status) async {
    // When device indicates connection is back, validate it
    if (status == InternetStatus.connected && !_hasConnection) {
      await _validateConnection();
    } else if (status == InternetStatus.disconnected) {
      _updateConnectionState(false);
    }
  }

  Future<void> _validateConnection() async {
    try {
      final response = await http
          .get(Uri.parse('https://dns.google/resolve?name=google.com'))
          .timeout(const Duration(seconds: 3));

      _consecutiveFailures = 0;
      _updateConnectionState(response.statusCode == 200);
    } catch (e) {
      _consecutiveFailures++;
      if (_consecutiveFailures >= 2) {
        _updateConnectionState(false);
      }
    }
  }

  void _startPeriodicCheck() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => _validateConnection(),
    );
  }

  void _updateConnectionState(bool isConnected) {
    if (_hasConnection == isConnected) return;

    _hasConnection = isConnected;
    _lastOfflineTime = isConnected ? null : DateTime.now();
    notifyListeners();
  }

  @override
  void dispose() {
    _pingTimer?.cancel();
    super.dispose();
  }
}

// Simple widget wrapper


// Simple banner

// Usage
// void main() {
//   GetIt.I.registerLazySingleton(() => ConnectivityService());
  
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => GetIt.I<ConnectivityService>(),
//       child: MaterialApp(
//         home: ConnectivityWidget(
//           offlineChild: const OfflineBanner(),
//           child: const HomePage(),
//         ),
//       ),
//     ),
//   );
// }