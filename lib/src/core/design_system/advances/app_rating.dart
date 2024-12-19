class AppRating extends StatefulWidget {
  const AppRating({
    required this.value,
    required this.onChanged,
    this.itemCount = 5,
    this.itemSize = 24.0,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.disabled = false,
    super.key,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final int itemCount;
  final double itemSize;
  final EdgeInsetsGeometry itemPadding;
  final bool disabled;

  @override
  State<AppRating> createState() => _AppRatingState();
}

class _AppRatingState extends State<AppRating> {
  double _hoverValue = 0;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.itemCount, (index) {
        final value = index + 1;
        return Padding(
          padding: widget.itemPadding,
          child: MouseRegion(
            onEnter: (_) {
              if (!widget.disabled) {
                setState(() {
                  _isHovering = true;
                  _hoverValue = value.toDouble();
                });
              }
            },
            onExit: (_) {
              if (!widget.disabled) {
                setState(() {
                  _isHovering = false;
                });
              }
            },
            child: GestureDetector(
              onTap: widget.disabled ? null : () => widget.onChanged(value.toDouble()),
              child: Icon(
                _getIcon(value),
                size: widget.itemSize,
                color: _getColor(value),
              ),
            ),
          ),
        );
      }),
    );
  }

  IconData _getIcon(int value) {
    final threshold = _isHovering ? _hoverValue : widget.value;
    if (value <= threshold) {
      return Icons.star;
    }
    if (value - threshold < 1) {
      return Icons.star_half;
    }
    return Icons.star_border;
  }

  Color _getColor(int value) {
    if (widget.disabled) {
      return AppColors.textDisabled;
    }
    final threshold = _isHovering ? _hoverValue : widget.value;
    if (value <= threshold) {
      return AppColors.warning;
    }
    return AppColors.textSecondary;
  }
}
