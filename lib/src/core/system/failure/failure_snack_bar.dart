import 'package:flutter/material.dart';
import 'package:rh_host/src/core/error/failures/failure.dart';
import 'package:rh_host/src/core/system/failure/failure_config.dart';
import 'package:rh_host/src/core/system/failure/failure_icon.dart';
import 'package:rh_host/src/core/system/failure/failure_utils.dart';

class FailureSnackBar extends SnackBar {
  FailureSnackBar({
    required Failure failure,
    required FailureConfig config,
    super.key,
  }) : super(
          content: Row(
            children: [
              FailureIcon(failure: failure),
              const SizedBox(width: 8),
              Expanded(child: Text(failure.message)),
            ],
          ),
          backgroundColor: FailureUtils.getColor(failure),
          behavior: config.defaultSnackBarBehavior,
          duration: config.defaultDuration,
          action: config.actionMap[failure.code] != null
              ? SnackBarAction(
                  label: config.actionMap[failure.code]!.label,
                  onPressed: config.actionMap[failure.code]!.onPressed,
                  textColor: config.actionMap[failure.code]!.textColor,
                )
              : null,
        );
}
