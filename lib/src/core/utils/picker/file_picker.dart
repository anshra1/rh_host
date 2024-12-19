class AppFilePicker extends StatelessWidget {
  const AppFilePicker({
    required this.onFilesPicked,
    this.label,
    this.acceptedTypes = const ['*/*'],
    this.maxFiles = 1,
    this.maxSize = 10485760, // 10MB
    this.error,
    this.disabled = false,
    super.key,
  });

  final Function(List<File>) onFilesPicked;
  final String? label;
  final List<String> acceptedTypes;
  final int maxFiles;
  final int maxSize;
  final String? error;
  final bool disabled;

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: acceptedTypes
            .map((e) => e.replaceAll('*/', ''))
            .where((e) => e.isNotEmpty)
            .toList(),
        allowMultiple: maxFiles > 1,
      );

      if (result != null) {
        final files = result.files
            .map((file) => File(file.path!))
            .where((file) => file.lengthSync() <= maxSize)
            .take(maxFiles)
            .toList();

        onFilesPicked(files);
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppFonts.labelMedium,
          ),
          SizedBox(height: SpacingTokens.xxs),
        ],
        InkWell(
          onTap: disabled ? null : _pickFiles,
          child: Container(
            padding: EdgeInsets.all(SpacingTokens.md),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppSize.radiusMD),
              color: disabled ? AppColors.neutral200 : null,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload,
                  size: AppSize.iconLG,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: SpacingTokens.sm),
                Text(
                  'Click to upload',
                  style: AppFonts.bodyMedium,
                ),
                SizedBox(height: SpacingTokens.xxs),
                Text(
                  'Maximum file size: ${maxSize ~/ 1048576}MB',
                  style: AppFonts.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (error != null) ...[
          SizedBox(height: SpacingTokens.xxs),
          Text(
            error!,
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
