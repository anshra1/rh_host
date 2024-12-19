class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.error,
    this.disabled = false,
    super.key,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hint;
  final String? error;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppFonts.labelMedium,
          ),
          SizedBox(height: SpacingTokens.xxs),
        ],
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: disabled ? null : onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SpacingTokens.md,
              vertical: SpacingTokens.sm,
            ),
          ),
          style: AppFonts.bodyMedium.copyWith(
            color: disabled ? AppColors.textDisabled : null,
          ),
        ),
      ],
    );
  }
}
