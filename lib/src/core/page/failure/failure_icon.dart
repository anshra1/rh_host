import 'package:flutter/material.dart';
import 'package:rh_host/src/core/errror/failure.dart';
import 'package:rh_host/src/core/page/failure/failure_utils.dart';

class FailureIcon extends StatelessWidget {
  const FailureIcon({
    required this.failure, super.key,
  });

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Icon(
      FailureUtils.getIcon(failure),
      color: FailureUtils.getColor(failure),
    );
  }
}
