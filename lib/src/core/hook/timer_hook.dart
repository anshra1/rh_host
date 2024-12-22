// Dart imports:
import 'dart:async';

import 'package:flutter/widgets.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

Timer useTimer(Duration duration, [VoidCallback? onCompletedTimer]) {
  return use(
    _TimerHook(duration: duration, onCompletedTimer: onCompletedTimer),
  );
}

class _TimerHook extends Hook<Timer> {
  const _TimerHook({
    required this.duration,
    this.onCompletedTimer, // Made optional
  });

  final Duration duration;
  final VoidCallback? onCompletedTimer; // Made nullable

  @override
  _TimerHookState createState() =>
      _TimerHookState(duration: duration, onCompletedTimer: onCompletedTimer);
}

class _TimerHookState extends HookState<Timer, _TimerHook> {
  _TimerHookState({
    required this.duration,
    this.onCompletedTimer, // Made optional
  });

  final Duration duration;
  final VoidCallback? onCompletedTimer;
  late Timer _timer;

  @override
  void initHook() {
    super.initHook();
    _timer = Timer(duration, () {
      onCompletedTimer?.call(); // Safe call using ?. operator
    });
  }

  @override
  Timer build(BuildContext context) => _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  String get debugLabel => 'useTimer';
}
