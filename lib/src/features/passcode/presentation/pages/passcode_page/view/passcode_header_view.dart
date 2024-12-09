part of '../../../../import.dart';

class PasscodeHeader extends StatelessWidget {
  const PasscodeHeader({
    required this.passcode,
    required this.isError,
    super.key,
  });

  final String passcode;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kGap50,
        Icon(
          isError ? Icons.error_outline : Icons.lock_outline,
          size: 50,
          color: isError ? AppColor.red100 : AppColor.primaryColor,
        ),
        kGap20,
        Text(
          isError ? Strings.invalidPinCode : Strings.pleaseEnterPasscode,
          style: p18.bold.copyWith(
            color: isError ? AppColor.red100 : null,
          ),
        ),
        kGap20,
        PasscodeInput(
          passcode: passcode,
          //  isError: isError,
        ),
      ],
    );
  }
}
