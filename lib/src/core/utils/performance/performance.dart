// // lib/src/design/utils/performance/performance_monitor.dart
// class PerformanceMonitor {
//   factory PerformanceMonitor() => _instance;
//   PerformanceMonitor._();
//   static final _instance = PerformanceMonitor._();

//   final _metrics = <String, List<Duration>>{};
//   final _startTimes = <String, DateTime>{};

//   void startMetric(String name) {
//     _startTimes[name] = DateTime.now();
//   }

//   void endMetric(String name) {
//     final startTime = _startTimes.remove(name);
//     if (startTime != null) {
//       final duration = DateTime.now().difference(startTime);
//       _metrics[name] ??= [];
//       _metrics[name]!.add(duration);

//       if (_metrics[name]!.length > 100) {
//         _metrics[name]!.removeAt(0);
//       }

//       _logMetric(name, duration);
//     }
//   }

//   double getAverageTime(String name) {
//     final metrics = _metrics[name];
//     if (metrics == null || metrics.isEmpty) return 0;

//     final total = metrics.fold<int>(
//       0,
//       (sum, duration) => sum + duration.inMilliseconds,
//     );
//     return total / metrics.length;
//   }

//   void _logMetric(String name, Duration duration) {
//     debugPrint(
//       'Performance metric - $name: ${duration.inMilliseconds}ms '
//       '(avg: ${getAverageTime(name).toStringAsFixed(1)}ms)',
//     );
//   }

//   void clearMetrics() {
//     _metrics.clear();
//     _startTimes.clear();
//   }
// }

// // lib/src/design/utils/performance/widget_size_observer.dart
// class WidgetSizeObserver extends StatefulWidget {
//   const WidgetSizeObserver({
//     required this.child,
//     required this.onSizeChanged,
//     super.key,
//   });

//   final Widget child;
//   final void Function(Size size) onSizeChanged;

//   @override
//   State<WidgetSizeObserver> createState() => _WidgetSizeObserverState();
// }

// class _WidgetSizeObserverState extends State<WidgetSizeObserver> {
//   final _widgetKey = GlobalKey();
//   Size? _oldSize;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
//   }

//   void _notifySize() {
//     final context = _widgetKey.currentContext;
//     if (context == null) return;

//     final size = context.size;
//     if (size == null || size == _oldSize) return;

//     _oldSize = size;
//     widget.onSizeChanged(size);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<SizeChangedLayoutNotification>(
//       onNotification: (_) {
//         _notifySize();
//         return true;
//       },
//       child: SizeChangedLayoutNotifier(
//         key: _widgetKey,
//         child: widget.child,
//       ),
//     );
//   }
// }

// // lib/src/design/utils/state/safe_state.dart
// mixin SafeState<T extends StatefulWidget> on State<T> {
//   bool _mounted = true;

//   @override
//   void initState() {
//     super.initState();
//     _mounted = true;
//   }

//   @override
//   void dispose() {
//     _mounted = false;
//     super.dispose();
//   }

//   @override
//   void setState(VoidCallback fn) {
//     if (_mounted) {
//       super.setState(fn);
//     }
//   }
// }

// // lib/src/design/utils/state/bloc_observer.dart
// class AppBlocObserver extends BlocObserver {
//   AppBlocObserver({this.enableLogging = true});
//   final bool enableLogging;

//   @override
//   void onCreate(BlocBase bloc) {
//     super.onCreate(bloc);
//     if (enableLogging) {
//       debugPrint('onCreate -- ${bloc.runtimeType}');
//     }
//   }

//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     if (enableLogging) {
//       debugPrint(
//         'onChange -- ${bloc.runtimeType}, '
//         'currentState: ${change.currentState}, '
//         'nextState: ${change.nextState}',
//       );
//     }
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     if (enableLogging) {
//       debugPrint(
//         'onError -- ${bloc.runtimeType}, '
//         'error: $error, '
//         'stackTrace: $stackTrace',
//       );
//     }
//     super.onError(bloc, error, stackTrace);
//   }

//   @override
//   void onClose(BlocBase bloc) {
//     super.onClose(bloc);
//     if (enableLogging) {
//       debugPrint('onClose -- ${bloc.runtimeType}');
//     }
//   }
// }

// // lib/src/design/utils/state/value_cubit.dart
// class ValueCubit<T> extends Cubit<T> {
//   ValueCubit(super.initialState);

//   void setValue(T value) => emit(value);

//   void update(T Function(T currentState) updater) => emit(updater(state));
// }

// // Example usage
// class PerformanceExample extends StatefulWidget {
//   @override
//   State<PerformanceExample> createState() => _PerformanceExampleState();
// }

// class _PerformanceExampleState extends State<PerformanceExample>
//     with SafeState<PerformanceExample> {
//   final _performanceMonitor = PerformanceMonitor();
//   late ValueCubit<int> _counterCubit;

//   @override
//   void initState() {
//     super.initState();
//     _counterCubit = ValueCubit<int>(0);
//     Bloc.observer = AppBlocObserver();
//   }

//   Future<void> _performHeavyOperation() async {
//     _performanceMonitor.startMetric('heavy_operation');

//     // Simulate heavy operation
//     await Future.delayed(const Duration(seconds: 1));

//     _performanceMonitor.endMetric('heavy_operation');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         WidgetSizeObserver(
//           onSizeChanged: (size) {
//             debugPrint('Widget size changed: $size');
//           },
//           child: BlocBuilder<ValueCubit<int>, int>(
//             bloc: _counterCubit,
//             builder: (context, count) {
//               return Text('Count: $count');
//             },
//           ),
//         ),
//         AppButton(
//           label: 'Increment',
//           onPressed: () {
//             _counterCubit.update((state) => state + 1);
//           },
//         ),
//         AppButton(
//           label: 'Perform Heavy Operation',
//           onPressed: _performHeavyOperation,
//         ),
//       ],
//     );
//   }

//   @override
//   void dispose() {
//     _counterCubit.close();
//     super.dispose();
//   }
// }
