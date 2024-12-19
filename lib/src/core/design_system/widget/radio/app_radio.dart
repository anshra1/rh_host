class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.disabled = false,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: AppSize.buttonSM,
          width: AppSize.buttonSM,
          child: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: disabled ? null : onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        if (label != null) ...[
          SizedBox(width: SpacingTokens.sm),
          Expanded(
            child: Text(
              label!,
              style: AppFonts.bodyMedium.copyWith(
                color: disabled ? AppColors.textDisabled : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
