// Example of how ErrorCode enum might be defined
import 'package:rh_host/src/core/page/failure/failure_manager.dart';

enum ErrorCode {
  // HTTP Status Codes
  badRequest, // 400
  unauthorized, // 401
  forbidden, // 403
  notFound, // 404
  serverError, // 500

  // Authentication Errors
  userNotFound,
  wrongPassword,
  emailInUse,
  weakPassword,
  invalidEmail,
  authGeneric,

  // Network Errors
  noInternet,
  timeOut,
  networkError,
  connectionLost,

  // Server Errors
  serverGeneric,
 
  // Custom Errors
  notFoundPasscode,
  unknown,
}

