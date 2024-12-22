// lib/src/core/config/firebase_config.dart

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:rh_host/firebase_options.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';

class FirebaseConfig {
  const FirebaseConfig._();

  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

// change later
      if (!kDebugMode) {
        // Only enable Crashlytics in release mode
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

        FlutterError.onError = (errorDetails) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        };

        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(
            error,
            stack,
            fatal: true,
          );
          return true;
        };
      }

      //
      //

      await Future.wait([
        _configureFirestore(),
        _configureCrashlytics(),
        _configureAnalytics(),
        //  _configureMessaging(),
        _configureAuth(),
      ]);
    } catch (e, s) {
      DebugLogger.instance.error(
        'Failed to initialize Firebase',
        e,
        s,
      );
      rethrow;
    }
  }

  static Future<void> _configureFirestore() async {
    const settings = Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      //  timeoutDuration: Duration(seconds: kReleaseMode ? 60 : 30),
      sslEnabled: true,
    );

    FirebaseFirestore.instance.settings = settings;

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );

    await FirebaseFirestore.instance.enableNetwork();
  }

  static Future<void> _configureCrashlytics() async {
    if (kReleaseMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  }

  static Future<void> _configureAnalytics() async {
    final analytics = FirebaseAnalytics.instance;

    await analytics.setAnalyticsCollectionEnabled(kReleaseMode);

    if (kReleaseMode) {
      await analytics.logAppOpen();
      await analytics.setUserProperty(
        name: 'build_number',
        value: const String.fromEnvironment('BUILD_NUMBER', defaultValue: '0'),
      );
    }
  }

  // static Future<void> _configureMessaging() async {
  //   final messaging = FirebaseMessaging.instance;

  //   await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   await messaging.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   final token = await messaging.getToken();
  //   DebugLogger.instance.info('FCM Token: $token');
  // }

  static Future<void> _configureAuth() async {
    await FirebaseAuth.instance.setLanguageCode('en');

    if (!kReleaseMode) {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  }

  static Future<void> signOut() async {
    try {
      await Future.wait([
        FirebaseAuth.instance.signOut(),
        FirebaseFirestore.instance.terminate(),
        FirebaseFirestore.instance.clearPersistence(),
      ]);
    } catch (e, s) {
      DebugLogger.instance.error('Error during sign out', e, s);
      rethrow;
    }
  }

  static Future<void> clearCache() async {
    try {
      await Future.wait([
        FirebaseFirestore.instance.terminate(),
        FirebaseFirestore.instance.clearPersistence(),
      ]);
    } catch (e, s) {
      DebugLogger.instance.error('Error clearing cache', e, s);
      rethrow;
    }
  }
}
