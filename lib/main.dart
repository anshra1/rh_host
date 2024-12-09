// ignore_for_file: avoid_redundant_argument_values

// Package imports:
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// Project imports:
import 'package:rh_host/re_name.dart';
import 'package:rh_host/src/core/services/config/import.dart';
import 'package:rh_host/src/core/system/alert_system/alert_config.dart';
import 'package:rh_host/src/core/system/alert_system/alert_manager.dart';
import 'package:rh_host/src/core/system/failure/failure_manager.dart';

Future<void> main() async {
  try {
    // Keep splash screen up until app is fully initialized
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await init();
    // Remove splash screen
    FlutterNativeSplash.remove();

    await FailureManager.initialize(
      config: const FailureConfig(
        shouldShowStackTrace: kDebugMode,
      ),
    );

    AlertManager().initialize(
      config: const AlertConfig(
        defaultSnackBarBehavior: SnackBarBehavior.floating,
        defaultDuration: Duration(seconds: 3),
      ),
    );

    // Run app inside error boundary
    runApp(const RootApp());
  } catch (error, stackTrace) {
    // Log fatal initialization errors
    if (!kDebugMode) {
      await FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: true,
        reason: 'Error during app initialization',
      );
    }
    rethrow; // Rethrow to show error screen
  }
}
