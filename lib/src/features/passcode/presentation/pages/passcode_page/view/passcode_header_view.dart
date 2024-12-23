part of '../../../../import.dart';

class PasscodeHeader extends StatelessWidget {
  const PasscodeHeader({
    required this.passcode,
    required this.isError,
    this.iconSize = 50,
    this.spacing = 20,
    super.key,
  });

  final String passcode;
  final bool isError;
  final double iconSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    DebugLogger.instance.info('PasscodePage build $isError');
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing.h,
      children: [
        // Top spacing that adapts to screen size
        Gap(50.h),

        // Icon with state-based styling
        _buildStateIcon(context),

        // Message text with state-based styling
        _buildMessageText(context),

        // Passcode input field
        PasscodeInput(passcode: passcode),
      ],
    );
  }

  Widget _buildStateIcon(BuildContext context) {
    return AnimatedSwitcher(
      duration: MotionTokens.durationMD,
      child: Icon(
        key: ValueKey<bool>(isError),
        Icons.lock_outline,
        size: iconSize.w,
        color: isError ? context.iconError : context.customColors.info,
      ),
    );
  }

  Widget _buildMessageText(BuildContext context) {
    return AnimatedSwitcher(
      duration: MotionTokens.durationMD,
      child: AppText(
        isError ? Strings.passcodeFailed : Strings.pleaseEnterPasscode,
        color: isError ? context.textError : context.textPrimary,
        style: AppFonts.titleLarge.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
