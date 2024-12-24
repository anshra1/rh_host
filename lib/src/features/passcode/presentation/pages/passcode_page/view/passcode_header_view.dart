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
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: spacing.h,
      children: [
        // Top spacing that adapts to screen size
        SizedBox(height: 50.h),

        // Icon with state-based styling
        _buildStateIcon(context),

        // Message text with state-based styling
        _buildMessageText(context, colorScheme),
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
        color: isError ? context.colorIconError : context.colorStatusBar,
      ),
    );
  }

  Widget _buildMessageText(BuildContext context, ColorScheme colorScheme) {
    return AnimatedDefaultTextStyle(
      duration: MotionTokens.durationMD,
      style: AppFonts.titleLarge.copyWith(
        color: isError ? context.colorIconError : context.colorIconPrimary,
        fontWeight: FontWeight.w600,
      ),
      child: Text(
        isError ? Strings.passcodeFailed : Strings.pleaseEnterPasscode,
        style: context.textStyle.titleLarge!.copyWith(
          color: isError ? context.colorTextError : context.colorTextPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
