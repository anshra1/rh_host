class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    this.height,
    this.width,
    this.shape = AppSkeletonShape.rectangle,
    super.key,
  });

  final double? height;
  final double? width;
  final AppSkeletonShape shape;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.5, end: 1.0),
      duration: MotionTokens.durationLG,
      curve: MotionTokens.emphasized,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.neutral200.withOpacity(0.7),
              borderRadius: shape == AppSkeletonShape.circle
                  ? BorderRadius.circular(AppSize.radiusFull)
                  : BorderRadius.circular(AppSize.radiusSM),
            ),
          ),
        );
      },
    );
  }
}

enum AppSkeletonShape { rectangle, circle }
