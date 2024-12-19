class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.textInverse,
    this.icon,
    this.size = AppBadgeSize.medium,
    super.key,
  });

  final String label;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final AppBadgeSize size;

  double get _fontSize {
    switch (size) {
      case AppBadgeSize.small:
        return 10.sp;
      case AppBadgeSize.medium:
        return 12.sp;
      case AppBadgeSize.large:
        return 14.sp;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppBadgeSize.small:
        return EdgeInsets.symmetric(
          horizontal: SpacingTokens.xxs,
          vertical: SpacingTokens.xxxs,
        );
      case AppBadgeSize.medium:
        return EdgeInsets.symmetric(
          horizontal: SpacingTokens.xs,
          vertical: SpacingTokens.xxs,
        );
      case AppBadgeSize.large:
        return EdgeInsets.symmetric(
          horizontal: SpacingTokens.sm,
          vertical: SpacingTokens.xs,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSize.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: _fontSize + 2,
              color: textColor,
            ),
            SizedBox(width: SpacingTokens.xxs),
          ],
          Text(
            label,
            style: AppFonts.labelSmall.copyWith(
              color: textColor,
              fontSize: _fontSize,
            ),
          ),
        ],
      ),
    );
  }
}

enum AppBadgeSize { small, medium, large }
