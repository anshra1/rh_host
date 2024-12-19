// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:rh_host/src/core/design_system/base/motion.dart';
import 'package:rh_host/src/core/design_system/widget/buttons/import.dart';
import 'package:rh_host/src/core/enum/button_enum.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    required this.text,
    super.key,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.tooltip,
  });
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final Widget? icon;
  final String? tooltip;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: MotionTokens.durationSM,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: MotionTokens.emphasized,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isPressed && widget.onPressed != null) {
      _isPressed = true;
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      _isPressed = false;
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      _isPressed = false;
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: BaseButton(
              text: widget.text,
              onPressed: widget.onPressed,
              size: widget.size,
              variant: widget.variant,
              icon: widget.icon,
              tooltip: widget.tooltip,
            ),
          );
        },
      ),
    );
  }
}
