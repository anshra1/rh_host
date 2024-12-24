import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/base/edge_inset.dart';
import 'package:rh_host/src/core/extension/context.dart';
import 'package:rh_host/src/core/system/logger/debug_logger.dart';

class PasscodeInput extends StatelessWidget {
  const PasscodeInput({
    required String passcode,
    super.key,
  }) : _passcode = passcode;

  final String _passcode;

  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: AppEdgeInsets.all8,
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < _passcode.length
                ? context.colorTextLink
                : context.colorIconDisabled,
          ),
        ),
      ),
    );
  }
}
