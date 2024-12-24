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
    
    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          PasscodeHeader(passcode: passcode, isError: isError).padBottom(Spacing.lg24),
          PasscodeInput(passcode: passcode),
          const Spacer(),
          BaseButton(
            onPressed: onForgetPin,
            variant: ButtonVariant.text,
            text: Strings.forgetPin,
            textStyle:
                context.textStyle.bodyLarge!.bold.colour(context.colorIconInteractive),
          ),
          PasscodeKeypad(
            onDigitTap: onDigitTap,
            onDelete: onDelete,
            onForgetPin: onForgetPin,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}
