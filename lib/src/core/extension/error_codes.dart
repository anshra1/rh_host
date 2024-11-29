import 'package:rh_host/src/core/enum/error_codes.dart';

extension ErrorCodeX on ErrorCode {
  bool get requiresLogout => [
        ErrorCode.unauthorized,
        ErrorCode.forbidden,
      ].contains(this);

  bool get isRecoverable => [
        ErrorCode.noInternet,
        ErrorCode.timeOut,
        ErrorCode.badRequest,
      ].contains(this);

  bool get shouldRetry => [
        ErrorCode.noInternet,
        ErrorCode.timeOut,
        ErrorCode.serverError,
      ].contains(this);
}
