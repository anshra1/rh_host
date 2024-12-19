part of '../../../../import.dart';

class PasscodeKeypad extends StatelessWidget {
  const PasscodeKeypad({
    required this.onDigitTap,
    required this.onDelete,
    required this.onForgetPin,
    required this.isLoading,
    super.key,
  });

  final ValueChanged<String> onDigitTap;
  final VoidCallback onDelete;
  final VoidCallback onForgetPin;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onForgetPin,
          child: Text(
            Strings.forgetPin,
            style: context.theme.textTheme.bodyLarge!.bold.primaryColor,
          ),
        ).padRight(10),
        IgnorePointer(
          ignoring: isLoading,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index == 9) return const SizedBox.shrink();
              if (index == 10) return _buildKey('0', onDigitTap);
              if (index == 11) {
                return _buildKey(
                  '⌫',
                  (_) => onDelete(),
                  color: AppColors.error,
                );
              }
              return _buildKey('${index + 1}', onDigitTap);
            },
          ).pad(20),
        ),
        20.gap,
      ],
    );
  }

  Widget _buildKey(
    String label,
    ValueChanged<String> onTap, {
    Color? color,
  }) {
    return InkWell(
      onTap: () => onTap(label),
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? AppColors.neutral400,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ).center(),
      ),
    );
  }
}
