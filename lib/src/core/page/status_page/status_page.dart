// import 'package:flutter/material.dart';
// import 'package:rh_host/src/core/presentation/constants/colors.dart';
// import 'package:rh_host/src/core/presentation/page/status_page/status_config.dart';
// import 'package:rh_host/src/core/presentation/widgets/buttons/custom_elevated_button.dart';

// class StatusPage extends StatelessWidget {
//   const StatusPage({
//     required this.type,
//     required this.title,
//     required this.message,
//     required this.buttonText,
//     super.key,
//     this.onButtonPressed,
//     this.showAppBar = false,
//     this.customConfig,
//     this.secondaryButtonText,
//     this.onSecondaryButtonPressed,
//     this.buttonIcon,
//     this.secondaryButtonIcon,
//   });

//   static const String routeName = '/status';

//   final StatusType type;
//   final String title;
//   final String message;
//   final String buttonText;
//   final VoidCallback? onButtonPressed;
//   final bool showAppBar;
//   final StatusConfig? customConfig;
//   final String? secondaryButtonText;
//   final VoidCallback? onSecondaryButtonPressed;
//   final Widget? buttonIcon;
//   final Widget? secondaryButtonIcon;

//   StatusConfig get _config => customConfig ?? StatusConfig.defaultConfigs[type]!;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: showAppBar
//           ? AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               leading: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             )
//           : null,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               const Spacer(),
//               _buildStatusContent(context),
//               const Spacer(),
//               _buildButtons(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusContent(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         _buildStatusIcon(),
//         const SizedBox(height: 32),
//         Text(
//           title,
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: AppColor.textColor,
//               ),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           message,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: AppColor.secondryTextcolor,
//               ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusIcon() {
//     return Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: _config.backgroundColor,
//       ),
//       child: Center(
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: _config.primaryColor,
//           ),
//           child: Icon(
//             _config.icon,
//             color: Colors.white,
//             size: 36,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButtons(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AppElevatedButton(
//           width: double.infinity,
//           label: buttonText,
//           onPressed: onButtonPressed ?? () => Navigator.of(context).pop(),
//           backgroundColor: _config.primaryColor,
//           contentPadding: const EdgeInsets.symmetric(vertical: 16),
//           leadingIcon: buttonIcon,
//         ),
//         if (secondaryButtonText != null) ...[
//           const SizedBox(height: 16),
//           AppElevatedButton(
//             width: double.infinity,
//             label: secondaryButtonText!,
//             onPressed: onSecondaryButtonPressed,
//             backgroundColor: Colors.white,
//             foregroundColor: _config.primaryColor,
//             contentPadding: const EdgeInsets.symmetric(vertical: 16),
//             leadingIcon: secondaryButtonIcon,
//           ),
//         ],
//       ],
//     );
//   }
// }

// // Example Usage:
// /*
// // Success Screen
// StatusScreen(
//   type: StatusType.success,
//   title: 'Success',
//   message: 'Your message was sent successfully',
//   buttonText: 'Continue',
//   onButtonPressed: () => context.go('/home'),
// );

// // Error Screen
// StatusScreen(
//   type: StatusType.error,
//   title: 'Error',
//   message: 'Something went wrong. Please try again.',
//   buttonText: 'Try Again',
//   secondaryButtonText: 'Go Back',
//   onButtonPressed: () => retryOperation(),
//   onSecondaryButtonPressed: () => Navigator.pop(context),
// );

// // Custom Status Screen
// StatusScreen(
//   type: StatusType.info,
//   title: 'Payment Pending',
//   message: 'Your payment is being processed',
//   buttonText: 'Check Status',
//   customConfig: StatusConfig(
//     primaryColor: Colors.purple,
//     backgroundColor: Colors.purple[50]!,
//     icon: Icons.payment,
//   ),
// );
// */