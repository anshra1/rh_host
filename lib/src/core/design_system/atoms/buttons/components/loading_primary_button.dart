// ignore_for_file: avoid_redundant_argument_values

part of '../import.dart';

class LoadingPrimaryButton extends HookWidget {
  const LoadingPrimaryButton({
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.medium,
    this.icon,
    this.tooltip,
    this.onError,
    super.key,
  });

  final String text;
  final Future<void> Function() onPressed;
  final ButtonSize size;
  final Widget? icon;
  final String? tooltip;
  final VoidCallback? onError;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);

    return BaseButton(
      text: text,
      onPressed: isLoading.value
          ? null
          : () async {
              isLoading.value = true;
              try {
                await onPressed();
              } catch (e) {
                onError?.call();
                // Show error feedback
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('An error occurred: $e'),
                      backgroundColor: AppColor.error,
                    ),
                  );
                }
              } finally {
                isLoading.value = false;
              }
            },
      size: size,
      variant: ButtonVariant.primary,
      isLoading: isLoading.value,
      icon: icon,
      tooltip: tooltip,
    );
  }
}
