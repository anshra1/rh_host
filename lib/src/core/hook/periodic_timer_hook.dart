import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Timer usePeriodicTimer(Duration duration, VoidCallback onTick) {
  return use(_TimerHook(duration: duration, onTick: onTick));
}

class _TimerHook extends Hook<Timer> {
  const _TimerHook({
    required this.duration,
    required this.onTick,
  });

  final Duration duration;
  final VoidCallback onTick;

  @override
  _TimerHookState createState() =>
      _TimerHookState(duration: duration, onTick: onTick);
}

class _TimerHookState extends HookState<Timer, _TimerHook> {
  _TimerHookState({
    required this.duration,
    required this.onTick,
  });

  final Duration duration;
  final VoidCallback onTick;
  late Timer _timer;

  @override
  void initHook() {
    super.initHook();
    _timer = Timer.periodic(duration, (_) {
      onTick();
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
  String get debugLabel => 'usePeriodicTimer';
}