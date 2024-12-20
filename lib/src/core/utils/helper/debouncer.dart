// // lib/src/design/utils/helpers/debouncer.dart
// class Debouncer {
//   Debouncer({this.duration = const Duration(milliseconds: 300)});
//   final Duration duration;
//   Timer? _timer;

//   void run(VoidCallback action) {
//     _timer?.cancel();
//     _timer = Timer(duration, action);
//   }

//   void dispose() {
//     _timer?.cancel();
//   }
// }

// // lib/src/design/utils/helpers/throttler.dart
// class Throttler {
//   Throttler({this.duration = const Duration(milliseconds: 300)});
//   final Duration duration;
//   Timer? _timer;
//   bool _isReady = true;

//   void run(VoidCallback action) {
//     if (_isReady) {
//       action();
//       _isReady = false;
//       _timer = Timer(duration, () {
//         _isReady = true;
//       });
//     }
//   }

//   void dispose() {
//     _timer?.cancel();
//   }
// }
