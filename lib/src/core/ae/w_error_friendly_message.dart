// // lib/core/error/error_handler.dart

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:rh_host/src/core/ae/error_details.dart';
// import 'package:rh_host/src/core/error/exception.dart';

// class ErrorFriendlyMessage {

//   String showUserMessage(ErrorDetails errorDetails) {
//     // Get user-friendly message based on error category
//     switch (errorDetails.category) {
//       case ErrorCategory.network:
//         return 'Please check your internet connection and try again';

//       case ErrorCategory.authentication:
//         if (errorDetails.originalError is FirebaseAuthException) {
//           final error = errorDetails.originalError as FirebaseAuthException;
//           return _getFirebaseAuthMessage(error.code);
//         }
//         return 'Your session has expired. Please sign in again';

//       case ErrorCategory.validation:
//         // Return specific validation message if available
//         return errorDetails.message.isNotEmpty
//             ? errorDetails.message
//             : 'Please check your input and try again';

//       case ErrorCategory.server:
//         if (errorDetails.originalError is DioException) {
//           final error = errorDetails.originalError as DioException;
//           return _getDioErrorMessage(error);
//         }
//         return "We're experiencing technical difficulties. Please try again later";

//       case ErrorCategory.database:
//         return 'Unable to access data. Please try again';

//       case ErrorCategory.unknown:
//       default:
//         return 'Something went wrong. Please try again';
//     }
//   }

//   String _getFirebaseAuthMessage(String code) {
//     switch (code) {
//       case 'user-not-found':
//         return 'No account found with this email';
//       case 'wrong-password':
//         return 'Incorrect password, please try again';
//       case 'invalid-email':
//         return 'Please enter a valid email address';
//       case 'user-disabled':
//         return 'This account has been disabled';
//       case 'too-many-requests':
//         return 'Too many attempts. Please try again later';
//       case 'email-already-in-use':
//         return 'An account already exists with this email';
//       case 'weak-password':
//         return 'Please choose a stronger password';
//       default:
//         return 'Authentication failed. Please try again';
//     }
//   }

//   String _getDioErrorMessage(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         return 'Connection timed out. Please try again';
//       case DioExceptionType.receiveTimeout:
//         return 'Server is taking too long to respond';
//       case DioExceptionType.connectionError:
//         return 'Unable to connect to server';
//       default:
//         return 'Network error occurred. Please try again';
//     }
//   }
// }

// // Usage in repository:
// // class AuthRepositoryImpl implements AuthRepository {
// //   final AuthRemoteDataSource remoteDataSource;
// //   final ProductionErrorHandler errorHandler;

// //   AuthRepositoryImpl({
// //     required this.remoteDataSource,
// //     required this.errorHandler,
// //   });

// //   @override
// //   Future<Either<Failure, User>> login(LoginParams params) async {
// //     try {
// //       final result = await remoteDataSource.login(params);
// //       return Right(result);
// //     } catch (error, stackTrace) {
// //       final errorDetails = ErrorDetails(
// //         originalError: error,
// //         message: '',
// //         category: _getErrorCategory(error),
// //         severity: ErrorSeverity.high,
// //       );

// //       // Get user-friendly message
// //       final userMessage = errorHandler._showUserMessage(errorDetails);

// //       return Left(ServerFailure(
// //         message: userMessage,
// //         code: 'AUTH_ERROR',
// //       ));
// //     }
// //   }

// //   ErrorCategory _getErrorCategory(dynamic error) {
// //     if (error is FirebaseAuthException) {
// //       return ErrorCategory.authentication;
// //     }
// //     if (error is DioException) {
// //       return ErrorCategory.network;
// //     }
// //     // ... other error types
// //     return ErrorCategory.unknown;
// //   }
// // }
