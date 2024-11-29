// import 'package:firebase_auth/firebase_auth.dart';

//  class AppException implements Exception {  // Stack trace for debugging

//   const AppException({
//     required this.code,
//     required this.message,
//     this.details,
//     this.stackTrace,
//   });

//   // Example of usage with Firebase Auth:
//   factory AppException.fromFirebaseAuth(FirebaseAuthException e) {
//     return AppException(
//       code: e.code,  // Firebase provides error codes like 'wrong-password'
//       message: 'Authentication failed',  // User-friendly message
//       details: e.message,  // Original Firebase error message
//       stackTrace: e.stackTrace,
//     );
//   }
//   final String code;      // Error code (e.g., 'user-not-found')
//   final String message;   // User-friendly message
//   final String? details;  // Technical details
//   final StackTrace? stackTrace;
// }

// // Example of a specific exception:
// class AuthException extends AppException {
//   AuthException({
//     required super.code,
//     required super.message,
//     super.details,
//     super.stackTrace,
//   });

//   // Create from Firebase error
//   factory AuthException.fromFirebase(FirebaseAuthException e) {
//     return AuthException(
//       code: e.code,
//       message: _getReadableMessage(e.code),
//       details: e.message,
//       stackTrace: e.stackTrace,
//     );
//   }

//   static String _getReadableMessage(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return 'No account found with this email';
//       case 'wrong-password':
//         return 'Incorrect password';
//       default:
//         return 'Authentication failed';
//     }
//   }
// }