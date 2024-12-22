import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityProvider() {
    _initConnectivity();
  }
  
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;

  ConnectivityResult get connectionStatus => _connectionStatus;

  Future<void> _initConnectivity() async {
    try {
      _connectionStatus = (await _connectivity.checkConnectivity()) as ConnectivityResult;
      notifyListeners();
    } catch (e) {
      debugPrint('Error checking connectivity: $e');
    }

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   _connectionStatus = result;
    //   notifyListeners();
    // });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
