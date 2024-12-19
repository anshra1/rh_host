class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    this.label,
    this.disabled = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: disabled ? null : onChanged,
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
