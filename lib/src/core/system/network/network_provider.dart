// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

// Project imports:
import 'package:rh_host/src/core/system/network/network_info.dart';

// lib/core/providers/network_provider.dart
class NetworkProvider extends ChangeNotifier {
  NetworkProvider(this._networkInfo) {
    _init();
  }
  final NetworkChecker _networkInfo;
  StreamSubscription<InternetStatus>? _subscription;
  bool _hasConnection = false;

  bool get hasConnection => _hasConnection;

  Future<void> _init() async {
    _hasConnection = await _networkInfo.isConnected;
    notifyListeners();

    _subscription = _networkInfo.onStatusChange.listen((status) {
      _hasConnection = status == InternetStatus.connected;
      notifyListeners();
    });
  }

  Future<void> checkConnection() async {
    _hasConnection = await _networkInfo.isConnected;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
