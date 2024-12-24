import 'package:flutter/material.dart';
import 'package:rh_host/src/core/page/fallback_page/error_boundary.dart';

class ErrorBoundaryTestPage extends StatelessWidget {
  const ErrorBoundaryTestPage({super.key});

  static const routeName = '/error-boundary-test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Boundary Test')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildErrorButton(
            context,
            'Throw Simple Error',
            () => throw Exception('Simple test error'),
          ),

          _buildErrorButton(
            context,
            'Null Reference Error',
            () {
              String? nullString;
              // ignore: invalid_use_of_protected_member
              nullString!.length;
            },
          ),

          _buildErrorButton(
            context,
            'Async Error',
            () async {
              await Future<void>.delayed(const Duration(seconds: 1));
              throw Exception('Async error test');
            },
          ),

          _buildErrorButton(
            context,
            'State Error',
            () {
              // Try to use context after widget dispose
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
              });
            },
          ),

          _buildErrorButton(
            context,
            'Widget Build Error',
            () {
              ErrorWidget('Intentional build error');
            },
          ),

          _buildErrorButton(
            context,
            'Resource Not Found Error',
            () {
              // Attempt to load non-existent image
              // ignore: unnecessary_statements
              Image.asset('non_existent_image.png').image;
            },
          ),

          _buildErrorButton(
            context,
            'Stack Overflow Error',
            _createRecursiveError,
          ),

          // Test error recovery
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => ErrorBoundary(
                    child: _RecoverableErrorWidget(),
                  ),
                ),
              );
            },
            child: const Text('Test Error Recovery'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorButton(
    BuildContext context,
    String label,
    VoidCallback errorTrigger,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => ErrorBoundary(
                onError: (details) {
                  debugPrint('Error caught: ${details.exception}');
                  debugPrint('Stack trace: ${details.stack}');
                },
                child: Builder(
                  builder: (context) {
                    errorTrigger();
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          );
        },
        child: Text(label),
      ),
    );
  }

  void _createRecursiveError() {
    _createRecursiveError();
  }
}

class _RecoverableErrorWidget extends StatefulWidget {
  @override
  State<_RecoverableErrorWidget> createState() => _RecoverableErrorWidgetState();
}

class _RecoverableErrorWidgetState extends State<_RecoverableErrorWidget> {
  bool _hasError = true;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      throw Exception('Recoverable error test');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Recovered')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Successfully recovered from error!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _hasError = true),
              child: const Text('Trigger Error Again'),
            ),
          ],
        ),
      ),
    );
  }
}
