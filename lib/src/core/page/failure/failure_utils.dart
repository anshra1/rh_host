import 'package:flutter/material.dart';
import 'package:rh_host/src/core/enum/error_codes.dart';
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';

class FailureUtils {
  const FailureUtils._();

  static IconData getIcon(Failure failure) {
    return switch (failure.code) {
      // Network related
      ErrorCode.noInternet || ErrorCode.connectionLost => Icons.wifi_off,
      ErrorCode.timeOut => Icons.timer_off,
      ErrorCode.networkError => Icons.cloud_off,

      // Auth related
      ErrorCode.unauthorized ||
      ErrorCode.forbidden ||
      ErrorCode.authGeneric =>
        Icons.security,

      // User related
      ErrorCode.userNotFound ||
      ErrorCode.wrongPassword ||
      ErrorCode.invalidEmail =>
        Icons.person_off,

      // Server related
      ErrorCode.serverError || ErrorCode.serverGeneric => Icons.error_outline,

      // Not found
      ErrorCode.notFound || ErrorCode.notFoundPasscode => Icons.search_off,

      // Validation
      ErrorCode.weakPassword || ErrorCode.emailInUse => Icons.warning_amber_rounded,

      // Default
      _ => Icons.error_outline,
    };
  }

  static Color getColor(Failure failure) {
    // First check severity
    final severityColor = switch (failure.severity) {
      ErrorSeverity.low => Colors.blue.shade700,
      ErrorSeverity.medium => Colors.orange.shade700,
      ErrorSeverity.high => Colors.red.shade700,
      ErrorSeverity.fatal => Colors.red.shade900,
      ErrorSeverity.unknown => Colors.blue.shade700,
    };

    // Then check if there's a specific color for the error code
    final codeColor = switch (failure.code) {
      ErrorCode.noInternet ||
      ErrorCode.connectionLost ||
      ErrorCode.networkError =>
        Colors.blue.shade700,
      ErrorCode.unauthorized || ErrorCode.forbidden => Colors.orange.shade700,
      ErrorCode.serverError || ErrorCode.serverGeneric => Colors.red.shade700,
      _ => null,
    };

    // Return code-specific color if available, otherwise severity color
    return codeColor ?? severityColor;
  }

  static String getTitle(Failure failure) {
    return switch (failure.code) {
      // Network related
      ErrorCode.noInternet || ErrorCode.connectionLost => 'No Internet Connection',
      ErrorCode.timeOut => 'Connection Timeout',
      ErrorCode.networkError => 'Network Error',

      // Auth related
      ErrorCode.unauthorized => 'Authentication Required',
      ErrorCode.forbidden => 'Access Denied',
      ErrorCode.authGeneric => 'Authentication Error',

      // User related
      ErrorCode.userNotFound => 'User Not Found',
      ErrorCode.wrongPassword => 'Invalid Password',
      ErrorCode.invalidEmail => 'Invalid Email',
      ErrorCode.emailInUse => 'Email Already in Use',
      ErrorCode.weakPassword => 'Weak Password',

      // Server related
      ErrorCode.serverError || ErrorCode.serverGeneric => 'Server Error',

      // Not found
      ErrorCode.notFound => 'Not Found',
      ErrorCode.notFoundPasscode => 'Passcode Not Found',
      ErrorCode.validation => 'Validation Error',

      // Default
      _ => failure.category.name.toTitleCase(),
    };
  }

  // static String getDefaultMessage(Failure failure) {
  //   return switch (failure.code) {
  //     ErrorCode.noInternet => 'Please check your internet connection and try again',
  //     ErrorCode.connectionLost => 'Your internet connection was lost. Please try again',
  //     ErrorCode.timeOut => 'The connection timed out. Please try again',
  //     ErrorCode.networkError => 'Unable to connect to the server. Please try again',
  //     ErrorCode.unauthorized => 'Please login to continue',
  //     ErrorCode.forbidden => "You don't have permission to access this",
  //     ErrorCode.authGeneric => 'Authentication failed. Please try again',
  //     ErrorCode.userNotFound => 'No account found with these credentials',
  //     ErrorCode.wrongPassword => 'The password you entered is incorrect',
  //     ErrorCode.invalidEmail => 'Please enter a valid email address',
  //     ErrorCode.emailInUse => 'This email is already registered',
  //     ErrorCode.weakPassword => 'Please choose a stronger password',
  //     ErrorCode.serverError => 'Something went wrong on our end. Please try again later',
  //     ErrorCode.serverGeneric => 'An unexpected error occurred. Please try again',
  //     ErrorCode.notFound => 'The requested resource was not found',
  //     ErrorCode.notFoundPasscode => 'The passcode was not found',
  //     _ => 'An unexpected error occurred',
  //   };
  // }

  static bool shouldRetry(Failure failure) {
    return switch (failure.code) {
      ErrorCode.noInternet ||
      ErrorCode.connectionLost ||
      ErrorCode.timeOut ||
      ErrorCode.networkError ||
      ErrorCode.serverError =>
        true,
      _ => false,
    };
  }

  static Duration getDisplayDuration(Failure failure) {
    return switch (failure.severity) {
      ErrorSeverity.low => const Duration(seconds: 2),
      ErrorSeverity.medium => const Duration(seconds: 3),
      ErrorSeverity.high => const Duration(seconds: 4),
      ErrorSeverity.fatal => const Duration(seconds: 5),
      ErrorSeverity.unknown => const Duration(seconds: 3),
    };
  }

  static bool shouldVibrate(Failure failure) {
    return failure.severity.value >= ErrorSeverity.medium.value;
  }
}

// Extension to help with string formatting
extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split('_')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}

// Helper class to manage animations
class FailureAnimationDurations {
  static const showDuration = Duration(milliseconds: 200);
  static const hideDuration = Duration(milliseconds: 150);
  static const autoHideDuration = Duration(seconds: 3);
}

// You can also add animations
class FailureSlideTransition extends StatelessWidget {
  const FailureSlideTransition({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1, end: 0),
      duration: FailureAnimationDurations.showDuration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * 20),
          child: Opacity(
            opacity: value + 1,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
