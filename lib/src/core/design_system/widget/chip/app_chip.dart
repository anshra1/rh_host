class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    this.onTap,
    this.onDeleted,
    this.selected = false,
    this.disabled = false,
    this.avatar,
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool selected;
  final bool disabled;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      onSelected: disabled ? null : (value) => onTap?.call(),
      selected: selected,
      avatar: avatar,
      onDeleted: disabled ? null : onDeleted,
      labelStyle: AppFonts.labelMedium.copyWith(
        color: disabled
            ? AppColors.textDisabled
            : selected
                ? AppColors.textInverse
                : AppColors.textPrimary,
      ),
      backgroundColor: AppColors.surfaceHighlight,
      selectedColor: AppColors.primaryColor,
      disabledColor: AppColors.neutral200,
    );
  }
}
