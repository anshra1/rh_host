// firebase_error_config.dart

// Package imports:
import 'package:firebase_core/firebase_core.dart';

// Project imports:
import 'package:rh_host/src/core/enum/error_catogory.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';

class FirebaseErrorConfig {
  static ErrorCategory getCategory(FirebaseException error) {
    switch (error.plugin) {
      case 'firebase_auth':
        return ErrorCategory.authentication;

      case 'cloud_firestore':
        return ErrorCategory.firestoreClient;

      case 'firebase_storage':
        return ErrorCategory.firebaseStorage;

      case 'firebase_core':
        return ErrorCategory.firebaseCore;

      case 'firebase_messaging':
        return ErrorCategory.firebaseMessaging;

      case 'firebase_crashlytics':
        return ErrorCategory.firebaseCrashlytics;

      case 'firebase_analytics':
        return ErrorCategory.firebaseAnalytics;

      default:
        return ErrorCategory.unknown;
    }
  }

  static ErrorCode getErrorCode(FirebaseException error) {
    switch (error.plugin) {
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

  // Complete Firebase Auth Error Codes
  static final Map<String, ErrorSeverity> authSeverityMap = {
    // Sign-in/Sign-up Errors
    'auth/email-already-exists': ErrorSeverity.medium,
    'auth/email-already-in-use': ErrorSeverity.medium,
    'auth/invalid-email': ErrorSeverity.medium,
    'auth/invalid-password': ErrorSeverity.medium,
    'auth/wrong-password': ErrorSeverity.medium,
    'auth/user-not-found': ErrorSeverity.medium,
    'auth/weak-password': ErrorSeverity.low,
    'auth/user-disabled': ErrorSeverity.high,
    'auth/user-cancelled': ErrorSeverity.low,
    'auth/operation-not-allowed': ErrorSeverity.high,
    'auth/account-exists-with-different-credential': ErrorSeverity.medium,
    'auth/user-mismatch': ErrorSeverity.high,
    'auth/credential-already-in-use': ErrorSeverity.medium,
    'auth/invalid-credential': ErrorSeverity.high,

    // Session/Token Errors
    'auth/invalid-verification-code': ErrorSeverity.medium,
    'auth/invalid-verification-id': ErrorSeverity.medium,
    'auth/user-token-expired': ErrorSeverity.high,
    'auth/token-expired': ErrorSeverity.high,
    'auth/invalid-custom-token': ErrorSeverity.high,
    'auth/requires-recent-login': ErrorSeverity.medium,
    'auth/user-token-mismatch': ErrorSeverity.high,
    'auth/invalid-user-token': ErrorSeverity.high,

    // Phone Auth Errors
    'auth/invalid-phone-number': ErrorSeverity.medium,
    'auth/missing-phone-number': ErrorSeverity.medium,
    'auth/quota-exceeded': ErrorSeverity.high,
    'auth/maximum-second-factor-count-exceeded': ErrorSeverity.high,
    'auth/code-expired': ErrorSeverity.medium,

    // MFA (Multi-Factor Authentication) Errors
    'auth/second-factor-already-in-use': ErrorSeverity.medium,
    'auth/invalid-multi-factor-session': ErrorSeverity.high,
    'auth/missing-multi-factor-info': ErrorSeverity.medium,
    'auth/missing-multi-factor-session': ErrorSeverity.medium,
    'auth/invalid-multi-factor-info': ErrorSeverity.medium,

    // Action Code Errors
    'auth/expired-action-code': ErrorSeverity.medium,
    'auth/invalid-action-code': ErrorSeverity.medium,
    'auth/missing-action-code': ErrorSeverity.medium,

    // Other Auth Errors
    'auth/network-request-failed': ErrorSeverity.medium,
    'auth/too-many-requests': ErrorSeverity.high,
    'auth/web-storage-unsupported': ErrorSeverity.high,
    'auth/invalid-continue-uri': ErrorSeverity.medium,
    'auth/unauthorized-continue-uri': ErrorSeverity.high,
    'auth/missing-continue-uri': ErrorSeverity.medium,
    'auth/missing-android-pkg-name': ErrorSeverity.medium,
    'auth/missing-ios-bundle-id': ErrorSeverity.medium,
    'auth/invalid-dynamic-link-domain': ErrorSeverity.high,
  };

  // Complete Firestore Error Codes
  static final Map<String, ErrorSeverity> firestoreSeverityMap = {
    // Permission Errors
    'permission-denied': ErrorSeverity.high,
    'unauthenticated': ErrorSeverity.high,

    // Resource Errors
    'cancelled': ErrorSeverity.low,
    'unknown': ErrorSeverity.high,
    'deadline-exceeded': ErrorSeverity.high,
    'not-found': ErrorSeverity.medium,
    'already-exists': ErrorSeverity.medium,
    'resource-exhausted': ErrorSeverity.high,
    'failed-precondition': ErrorSeverity.high,
    'aborted': ErrorSeverity.medium,
    'out-of-range': ErrorSeverity.medium,

    // System Errors
    'internal': ErrorSeverity.high,
    'unavailable': ErrorSeverity.high,
    'data-loss': ErrorSeverity.high,
    'unimplemented': ErrorSeverity.high,
    'invalid-argument': ErrorSeverity.medium,
  };

  // Complete Storage Error Codes
  static final Map<String, ErrorSeverity> storageSeverityMap = {
    'storage/unknown': ErrorSeverity.high,
    'storage/object-not-found': ErrorSeverity.medium,
    'storage/bucket-not-found': ErrorSeverity.high,
    'storage/project-not-found': ErrorSeverity.high,
    'storage/quota-exceeded': ErrorSeverity.high,
    'storage/unauthenticated': ErrorSeverity.high,
    'storage/unauthorized': ErrorSeverity.high,
    'storage/retry-limit-exceeded': ErrorSeverity.high,
    'storage/invalid-checksum': ErrorSeverity.medium,
    'storage/canceled': ErrorSeverity.low,
    'storage/invalid-event-name': ErrorSeverity.medium,
    'storage/invalid-url': ErrorSeverity.medium,
    'storage/invalid-argument': ErrorSeverity.medium,
    'storage/no-default-bucket': ErrorSeverity.high,
    'storage/cannot-slice-blob': ErrorSeverity.medium,
    'storage/server-file-wrong-size': ErrorSeverity.medium,
  };

  // Complete error recoverability mapping
  static final Map<String, bool> recoverabilityMap = {
    // Auth Recoverable Errors
    'auth/email-already-in-use': true,
    'auth/invalid-email': true,
    'auth/invalid-password': true,
    'auth/wrong-password': true,
    'auth/user-not-found': true,
    'auth/weak-password': true,
    'auth/requires-recent-login': true,
    'auth/invalid-verification-code': true,
    'auth/invalid-verification-id': true,
    'auth/invalid-phone-number': true,
    'auth/code-expired': true,
    'auth/expired-action-code': true,
    'auth/invalid-action-code': true,
    'auth/network-request-failed': true,
    'auth/too-many-requests': true,

    // Auth Non-recoverable Errors
    'auth/user-disabled': false,
    'auth/operation-not-allowed': false,
    'auth/web-storage-unsupported': false,
    'auth/user-token-expired': false,
    'auth/unauthorized-continue-uri': false,

    // Firestore Recoverable Errors
    'not-found': true,
    'already-exists': true,
    'cancelled': true,
    'aborted': true,
    'deadline-exceeded': true,
    'resource-exhausted': true,
    'invalid-argument': true,

    // Firestore Non-recoverable Errors
    'permission-denied': false,
    'unauthenticated': false,
    'failed-precondition': false,
    'internal': false,
    'data-loss': false,
    'unimplemented': false,

    // Storage Recoverable Errors
    'storage/object-not-found': true,
    'storage/invalid-checksum': true,
    'storage/canceled': true,
    'storage/retry-limit-exceeded': true,
    'storage/invalid-url': true,
    'storage/invalid-argument': true,

    // Storage Non-recoverable Errors
    'storage/unauthorized': false,
    'storage/quota-exceeded': false,
    'storage/project-not-found': false,
    'storage/bucket-not-found': false,
    'storage/no-default-bucket': false,
  };

  // Get combined severity map
  static Map<String, ErrorSeverity> get _allSeverities => {
        ...authSeverityMap,
        ...firestoreSeverityMap,
        ...storageSeverityMap,
      };

  // Get error severity with fallback
  static ErrorSeverity getSeverity(FirebaseException error) {
    // Try exact code match
    final severity = _allSeverities[error.code];
    if (severity != null) return severity;

    // Try with plugin prefix
    final prefixedCode = '${error.plugin}/${error.code}';
    final prefixedSeverity = _allSeverities[prefixedCode];
    if (prefixedSeverity != null) return prefixedSeverity;

    // Default based on plugin
    return switch (error.plugin) {
      'firebase_auth' => ErrorSeverity.medium,
      'cloud_firestore' => ErrorSeverity.medium,
      'firebase_storage' => ErrorSeverity.medium,
      _ => ErrorSeverity.low,
    };
  }

  // User-friendly messages for all error codes
  static final Map<String, String> userMessages = {
    // Auth Messages
    'auth/email-already-in-use': 'This email is already registered',
    'auth/invalid-email': 'Please enter a valid email address',
    'auth/wrong-password': 'Incorrect password',
    'auth/user-not-found': 'No account found with this email',
    'auth/weak-password': 'Please choose a stronger password',
    'auth/user-disabled': 'This account has been disabled',
    'auth/requires-recent-login': 'Please login again to continue',
    'auth/too-many-requests': 'Too many attempts. Please try again later',
    'auth/invalid-verification-code': 'Invalid verification code',
    'auth/invalid-phone-number': 'Invalid phone number',
    'auth/code-expired': 'Verification code has expired',
    'auth/operation-not-allowed': 'Operation not allowed',

    // Firestore Messages
    'permission-denied': "You don't have permission to perform this action",
    'not-found': 'The requested data was not found',
    'already-exists': 'This data already exists',
    'cancelled': 'Operation was cancelled',
    'deadline-exceeded': 'Operation timed out',
    'resource-exhausted': 'System resource limit exceeded',
    'failed-precondition': 'Operation cannot be performed in current state',
    'aborted': 'Operation was aborted',
    'out-of-range': 'Operation specified an invalid range',

    // Storage Messages
    'storage/unauthorized': 'Not authorized to access storage',
    'storage/object-not-found': 'File not found',
    'storage/bucket-not-found': 'Storage bucket not found',
    'storage/quota-exceeded': 'Storage quota exceeded',
    'storage/invalid-checksum': 'File integrity check failed',
    'storage/canceled': 'Operation cancelled',
    'storage/invalid-url': 'Invalid storage URL',
  };

  // User-friendly messages for all error codes
  static final Map<String, String> technicalMessageCodes = {
    // Firestore Messages
    'permission-denied': 'May be the problem in firestore rules',
  };

  static String technicalMessage(FirebaseException error) {
    return technicalMessageCodes[error.code] ?? '';
  }

  // Get recoverability status with fallback
  static bool isRecoverable(FirebaseException error) {
    // Try exact code match
    final recoverable = recoverabilityMap[error.code];
    if (recoverable != null) return recoverable;

    // Try with plugin prefix
    final prefixedCode = '${error.plugin}/${error.code}';
    final prefixedRecoverable = recoverabilityMap[prefixedCode];
    if (prefixedRecoverable != null) return prefixedRecoverable;

    // Default to recoverable
    return true;
  }

  // Get user message with fallback
  static String getUserMessage(FirebaseException error) {
    // Use Firebase's message if available and meaningful
    if (error.message != null &&
        error.message!.isNotEmpty &&
        !error.message!.contains('Exception')) {
      return error.message!;
    }

    // Try exact code match
    final message = userMessages[error.code];
    if (message != null) return message;

    // Try with plugin prefix
    final prefixedCode = '${error.plugin}/${error.code}';
    final prefixedMessage = userMessages[prefixedCode];
    if (prefixedMessage != null) return prefixedMessage;

    // Default based on plugin
    return switch (error.plugin) {
      'firebase_auth' => 'Authentication error occurred',
      'cloud_firestore' => 'Database error occurred',
      'firebase_storage' => 'Storage error occurred',
      _ => 'An unexpected error occurred',
    };
  }
}
