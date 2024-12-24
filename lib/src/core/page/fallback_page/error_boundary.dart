import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A widget that catches errors in its child widget subtree and displays
/// an error message instead of crashing the app.
class ErrorBoundary extends StatefulWidget {
  const ErrorBoundary({
    required this.child,
    this.fallbackBuilder,
    this.onError,
    this.showDetails = kDebugMode,
    super.key,
  });

  /// The widget to be wrapped with error handling.
  final Widget child;

  /// Optional custom error widget builder.
  final Widget Function(BuildContext context, FlutterErrorDetails error)? fallbackBuilder;

  /// Optional callback for error reporting.
  final void Function(FlutterErrorDetails details)? onError;

  /// Whether to show error details. Defaults to true in debug mode only.
  final bool showDetails;

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _error;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _attachErrorListener();
  }

  void _attachErrorListener() {
    FlutterError.onError = _handleFlutterError;
  }

  void _handleFlutterError(FlutterErrorDetails details) {
    if (mounted) {
      // Log error in debug mode
      if (kDebugMode) {
        debugPrint('Error caught by ErrorBoundary:');
        debugPrint(details.exception.toString());
        debugPrint(details.stack.toString());
      }

      // Call error callback if provided
      widget.onError?.call(details);

      setState(() {
        _error = details;
        _hasError = true;
      });
    }
  }

  void _resetError() {
    setState(() {
      _error = null;
      _hasError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError && _error != null) {
      return widget.fallbackBuilder?.call(context, _error!) ??
          _DefaultErrorWidget(
            error: _error!,
            showDetails: widget.showDetails,
            onRetry: _resetError,
          );
    }

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(
        child: Builder(
          builder: (context) {
            ErrorWidget.builder = (details) {
              _handleFlutterError(details);
              return widget.fallbackBuilder?.call(context, details) ??
                  _DefaultErrorWidget(
                    error: details,
                    showDetails: widget.showDetails,
                    onRetry: _resetError,
                  );
            };
            return widget.child;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Reset error handler
    FlutterError.onError = FlutterError.presentError;
    super.dispose();
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget({
    required this.error,
    required this.showDetails,
    required this.onRetry,
  });

  final FlutterErrorDetails error;
  final bool showDetails;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (showDetails) ...[
                Text(
                  error.exception.toString(),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (error.stack != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        error.stack.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
