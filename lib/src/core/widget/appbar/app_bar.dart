import 'package:flutter/material.dart';
import 'package:rh_host/src/core/extension/context.dart';

class PrimaryAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBarWidget({
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.leadingIcon,
    this.onLeadingPressed,
    this.bottom,
    this.centerTitle = false,
    super.key,
  }) : assert(
          title == null || titleWidget == null,
          'Cannot provide both title and titleWidget',
        );

  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final PreferredSizeWidget? bottom;
  final bool? centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: backgroundColor ?? colorScheme.surface,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                leadingIcon ?? Icons.arrow_back_ios,
                size: 20,
                color: context.iconPrimary,
              ),
              onPressed: onLeadingPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null),
      foregroundColor: colorScheme.onSurface,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
      actions: actions,
      bottom: bottom,
    );
  }
}
