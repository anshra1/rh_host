import 'package:flutter/material.dart';
import 'package:rh_host/src/core/constants/colors.dart';

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
          margin: const EdgeInsets.all(8),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < _passcode.length
                ? AppColor.primaryColor
                : AppColor.backgroundGrey300,
          ),
        ),
      ),
    );
  }
}
