// Project imports:
import 'package:rh_host/src/core/enum/error_codes.dart';

extension FirebasePlugin on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get initials {
    if (isEmpty) return '';
    final parts = trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  bool get isValidEmail {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }

  bool get isValidPhone {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(this);
  }

  bool get isValidUrl {
    return RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    ).hasMatch(this);
  }

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
