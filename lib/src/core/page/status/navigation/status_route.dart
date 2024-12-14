part of '../../import.dart';

class StatusRoutes {
  static const String name = 'status';
  static const String path = '/status';

  static GoRoute route = GoRoute(
    path: path,
    name: name,
    builder: (context, state) {
      final config = state.extra is StatusScreenModel
          ? state.extra! as StatusScreenModel
          : throw Exception('Invalid status configuration provided');
      return StatusView(config: config);
    },
  );

  static Future<void> navigate(
    BuildContext context,
    StatusScreenModel config, {
    bool replace = false,
  }) async {
    if (replace) {
      return context.pushReplacementNamed(name, extra: config);
    }
    //return context.pushNamed(name, extra: config);
  }
}

// lib/src/features/status/di/status_module.dart
// class StatusModule {
//   static Future<void> init(GetIt sl) async {
//     // Register view model factory
//     sl.registerFactory(StatusViewModel.new);
//   }
// }


