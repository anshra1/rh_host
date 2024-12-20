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
        50.gap,
        Icon(
          isError ? Icons.error_outline : Icons.lock_outline,
          size: 50,
          color: isError ? AppColors.error : AppColors.primaryColor,
        ),
        20.gap,
        Text(
          isError ? Strings.invalidPinCode : Strings.pleaseEnterPasscode,
          style: p18.bold.copyWith(
            color: isError ? AppColors.error : null,
          ),
        ),
        20.gap,
        PasscodeInput(
          passcode: passcode,
          //  isError: isError,
        ),
      ],
    );
  }
}
