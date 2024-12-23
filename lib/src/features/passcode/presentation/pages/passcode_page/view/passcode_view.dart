part of '../../../../import.dart';

class PasscodeView extends StatelessWidget {
  const PasscodeView({
    required this.passcode,
    required this.isError,
    required this.isLoading,
    required this.onDigitTap,
    required this.onDelete,
    required this.onForgetPin,
    super.key,
  });

  final String passcode;
  final bool isError;
  final bool isLoading;
  final ValueChanged<String> onDigitTap;
  final VoidCallback onDelete;
  final VoidCallback onForgetPin;

  @override
  Widget build(BuildContext context) {
    DebugLogger.instance.info('PasscodePage build $isError');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PasscodeHeader(
              passcode: passcode,
              isError: isError,
            ),
            PasscodeKeypad(
              onDigitTap: onDigitTap,
              onDelete: onDelete,
              onForgetPin: onForgetPin,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
