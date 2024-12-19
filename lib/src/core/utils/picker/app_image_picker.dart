class AppImagePicker extends StatefulWidget {
  const AppImagePicker({
    required this.onImageSelected,
    this.initialImage,
    this.label,
    this.error,
    this.maxSize = 5242880, // 5MB
    this.allowedExtensions = const ['jpg', 'jpeg', 'png'],
    this.disabled = false,
    super.key,
  });

  final ValueChanged<File?> onImageSelected;
  final String? initialImage;
  final String? label;
  final String? error;
  final int maxSize;
  final List<String> allowedExtensions;
  final bool disabled;

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  File? _selectedImage;
  bool _isHovering = false;

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        if (file.lengthSync() <= widget.maxSize) {
          setState(() => _selectedImage = file);
          widget.onImageSelected(file);
        } else {
          context.showErrorSnackBar(
            'Image size must be less than ${widget.maxSize ~/ 1048576}MB',
          );
        }
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppFonts.labelMedium,
          ),
          SizedBox(height: SpacingTokens.xxs),
        ],
        MouseRegion(
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: GestureDetector(
            onTap: widget.disabled ? null : _pickImage,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: _isHovering ? AppColors.neutral100 : Colors.transparent,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppSize.radiusMD),
              ),
              child: _buildContent(),
            ),
          ),
        ),
        if (widget.error != null) ...[
          SizedBox(height: SpacingTokens.xxs),
          Text(
            widget.error!,
            style: AppFonts.labelSmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContent() {
    if (_selectedImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radiusMD),
            child: Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (_isHovering)
            Container(
              color: Colors.black45,
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: AppColors.textInverse,
                  size: AppSize.iconLG,
                ),
              ),
            ),
        ],
      );
    }

    if (widget.initialImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.radiusMD),
            child: Image.network(
              widget.initialImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (_isHovering)
            Container(
              color: Colors.black45,
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: AppColors.textInverse,
                  size: AppSize.iconLG,
                ),
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate,
          size: AppSize.iconXL,
          color: AppColors.textSecondary,
        ),
        SizedBox(height: SpacingTokens.sm),
        Text(
          'Click to upload',
          style: AppFonts.bodyMedium,
        ),
        SizedBox(height: SpacingTokens.xxs),
        Text(
          'Maximum file size: ${widget.maxSize ~/ 1048576}MB',
          style: AppFonts.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
