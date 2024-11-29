import 'package:flutter/material.dart';
import 'package:rh_host/src/core/errror/failure.dart';
import 'package:rh_host/src/core/page/failure/failure_config.dart';
import 'package:rh_host/src/core/page/failure/failure_icon.dart';
import 'package:rh_host/src/core/page/failure/failure_utils.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({
    required this.failure,
    required this.config,
    super.key,
  });

  final Failure failure;
  final FailureConfig config;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final action = config.actionMap[failure.code];

    return AlertDialog(
      icon: FailureIcon(failure: failure),
      title: Text(
        FailureUtils.getTitle(failure),
        style: theme.textTheme.titleLarge,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(failure.message),
          if ((failure.isRecoverable ?? false) && action != null) ...[
            const SizedBox(height: 8),
            Text(
              'Would you like to try again?',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        if ((failure.isRecoverable ?? false) && action != null)
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              action.onPressed();
            },
            style: FilledButton.styleFrom(
              foregroundColor: action.textColor,
              backgroundColor: action.backgroundColor,
            ),
            child: Text(action.label),
          ),
      ],
    );
  }
}
