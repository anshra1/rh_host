// Dart imports:
import 'dart:async';
import 'dart:collection';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/enum/error_severity.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';

class FailureConfig {
  const FailureConfig({
    this.displayDuration = const Duration(seconds: 3),
    this.shouldShowStackTrace = false,
    this.shouldLogError = true,
  });
  final Duration displayDuration;
  final bool shouldShowStackTrace;
  final bool shouldLogError;
}

class FailureManager {
  FailureManager._({required FailureConfig config}) : _config = config;
  static FailureManager? _instance;
  final FailureConfig _config;

  final Queue<_FailureItem> _queue = Queue<_FailureItem>();
  bool _isProcessing = false;

  static Future<void> initialize({FailureConfig? config}) async {
    if (_instance != null) {
      debugPrint('FailureManager already initialized');
      return;
    }

    _instance = FailureManager._(
      config: config ?? const FailureConfig(),
    );
  }

  static FailureManager get instance {
    if (_instance == null) {
      throw StateError(
        'FailureManager not initialized. Call FailureManager.initialize() first.',
      );
    }
    return _instance!;
  }

  Future<void> show(BuildContext context, Failure failure) async {
    if (!context.mounted) return;

    try {
      _queue.add(_FailureItem(context: context, failure: failure));
      if (!_isProcessing) {
        await _processQueue();
      }
    } catch (e, stackTrace) {
      debugPrint('Error showing failure: $e\n$stackTrace');
      // ignore: use_build_context_synchronously
      _showFallbackError(context, failure);
    }
  }

  Future<void> _processQueue() async {
    if (_queue.isEmpty || _isProcessing) return;

    _isProcessing = true;

    try {
      while (_queue.isNotEmpty) {
        final item = _queue.removeFirst();
        if (item.context.mounted) {
          await _showFailure(item.context, item.failure);
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _showFailure(BuildContext context, Failure failure) async {
    if (!context.mounted) return;

    // Log error if enabled
    if (_config.shouldLogError) {
      _logError(failure);
    }

    final theme = Theme.of(context);
    final errorColor = _getErrorColor(failure.severity);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Error code and category
            Row(
              children: [
                Text(
                  '[${failure.code.name}]',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onError.withOpacity(0.7),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  failure.category.name,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onError.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Error message
            Text(
              failure.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onError,
              ),
            ),
            // Recovery hint if not recoverable
            if (failure.isRecoverable == false) ...[
              const SizedBox(height: 4),
              Text(
                'This error cannot be recovered automatically',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onError.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
        backgroundColor: errorColor,
        duration: _getDisplayDuration(failure),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: theme.colorScheme.onError,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showFallbackError(BuildContext context, Failure failure) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failure.message),
        backgroundColor: _getErrorColor(failure.severity),
      ),
    );
  }

  void _logError(Failure failure) {
    debugPrint('''
FAILURE LOG
Code: ${failure.code}
Category: ${failure.category}
Severity: ${failure.severity}
Recoverable: ${failure.isRecoverable}
Message: ${failure.message}
    ''');
  }

  Color _getErrorColor(ErrorSeverity severity) {
    switch (severity) {
      case ErrorSeverity.fatal:
        return Colors.red.shade700;
      case ErrorSeverity.high:
        return Colors.red;
      case ErrorSeverity.medium:
        return Colors.orange;
      case ErrorSeverity.low:
        return Colors.grey.shade700;
      case ErrorSeverity.unknown:
        return Colors.grey.shade700;
    }
  }

  Duration _getDisplayDuration(Failure failure) {
    switch (failure.severity) {
      case ErrorSeverity.fatal:
        return const Duration(seconds: 10);
      case ErrorSeverity.high:
        return const Duration(seconds: 7);
      case ErrorSeverity.medium:
        return const Duration(seconds: 5);
      case ErrorSeverity.low:
        return _config.displayDuration;
      case ErrorSeverity.unknown:
        return _config.displayDuration;
    }
  }
}

class _FailureItem {
  _FailureItem({
    required this.context,
    required this.failure,
  });
  final BuildContext context;
  final Failure failure;
}
