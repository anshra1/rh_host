import 'package:rh_host/src/core/enum/error_codes.dart';

extension FirebasePlugin on String {
  ErrorCode get getFirebaseErrorCode {
    switch (this) {
      case 'firebase_auth':
        return ErrorCode.authentication;

      case 'cloud_firestore':
        return ErrorCode.firestoreClient;

      case 'firebase_storage':
        return ErrorCode.firebaseStorage;

      case 'firebase_core':
        return ErrorCode.firebaseCore;

      case 'firebase_messaging':
        return ErrorCode.firebaseMessaging;

      case 'firebase_crashlytics':
        return ErrorCode.firebaseCrashlytics;

      case 'firebase_analytics':
        return ErrorCode.firebaseAnalytics;

      default:
        return ErrorCode.unknown;
    }
  }
}
