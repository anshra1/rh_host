// import 'package:flutter/widgets.dart';
// import 'package:rh_host/src/core/errror/error_codes.dart';
// import 'package:rh_host/src/core/errror/failure.dart';

// class ErrorHandler {
//   static Widget getErrorWidget(Failure failure) {
//     switch (failure.code) {
//       case ErrorCode.badRequest:
//         return ErrorView(
//           icon: Icons.error_outline,
//           message: failure.message,
//           actionButton: RetryButton(),
//         );

//       case ErrorCode.unauthorized:
//         return ErrorView(
//           icon: Icons.lock,
//           message: failure.message,
//           actionButton: LoginButton(),
//         );

//       case ErrorCode.noInternet:
//         return ErrorView(
//           icon: Icons.wifi_off,
//           message: failure.message,
//           actionButton: RefreshButton(),
//         );

//       default:
//         return GenericErrorView(message: failure.message);
//     }
//   }
// }
