// import 'package:flutter/material.dart';

// import 'package:rh_host/src/core/design_system/z_import.dart';

// class AppElevatedButton extends StatelessWidget {
//   const AppElevatedButton({
//     required this.label,
//     required this.onPressed,
//     this.backgroundColor = AppColor.primaryColor,
//     this.foregroundColor = Colors.white,
//     this.disabledBackgroundColor,
//     this.disabledForegroundColor,
//     this.textStyle,
//     this.contentPadding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//     this.borderRadius = 8.0,
//     this.elevation,
//     this.width,
//     this.height,
//     this.isLoading = false,
//     this.leadingIcon,
//     this.trailingIcon,
//     super.key,
//   });

//   final String label;
//   final VoidCallback? onPressed;
//   final Color backgroundColor;
//   final Color foregroundColor;
//   final Color? disabledBackgroundColor;
//   final Color? disabledForegroundColor;
//   final TextStyle? textStyle;
//   final EdgeInsetsGeometry contentPadding;
//   final double borderRadius;
//   final double? elevation;
//   final double? width;
//   final double? height;
//   final bool isLoading;
//   final Widget? leadingIcon;
//   final Widget? trailingIcon;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final defaultTextStyle = theme.textTheme.titleMedium?.copyWith(
//       color: foregroundColor,
//       fontWeight: FontWeight.w500,
//     );

//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor,
//           foregroundColor: foregroundColor,
//           disabledBackgroundColor: disabledBackgroundColor,
//           disabledForegroundColor: disabledForegroundColor,
//           elevation: elevation,
//           padding: contentPadding,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2.5,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               )
//             : Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (leadingIcon != null) ...[
//                     leadingIcon!,
//                     const SizedBox(width: 8),
//                   ],
//                   Text(
//                     label,
//                     style: textStyle ?? defaultTextStyle,
//                   ),
//                   if (trailingIcon != null) ...[
//                     const SizedBox(width: 8),
//                     trailingIcon!,
//                   ],
//                 ],
//               ),
//       ),
//     );
//   }
// }
