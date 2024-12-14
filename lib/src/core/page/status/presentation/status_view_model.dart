import 'dart:async';

import 'package:flutter/material.dart';

class StatusViewModel extends ChangeNotifier {
  Timer? _autoNavigateTimer;
  bool _disposed = false;

  bool get canPop => _autoNavigateTimer == null;

  void setupAutoNavigation(Duration duration, VoidCallback onComplete) {
    _autoNavigateTimer?.cancel();
    _autoNavigateTimer = Timer(duration, () {
      if (!_disposed) onComplete();
    });
  }

  @override
  void dispose() {
    _disposed = true;
    _autoNavigateTimer?.cancel();
    super.dispose();
  }
}