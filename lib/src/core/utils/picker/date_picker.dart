// class AppDatePicker extends StatelessWidget {
//   const AppDatePicker({
//     required this.selectedDate,
//     required this.onDateSelected,
//     this.firstDate,
//     this.lastDate,
//     this.label,
//     this.error,
//     this.disabled = false,
//     super.key,
//   });

//   final DateTime? selectedDate;
//   final ValueChanged<DateTime> onDateSelected;
//   final DateTime? firstDate;
//   final DateTime? lastDate;
//   final String? label;
//   final String? error;
//   final bool disabled;

//   Future<void> _showDatePicker(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: firstDate ?? DateTime(1900),
//       lastDate: lastDate ?? DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: Theme.of(context).colorScheme.copyWith(
//                   primary: AppColors.primaryColor,
//                   onPrimary: AppColors.textInverse,
//                   surface: AppColors.surface,
//                   onSurface: AppColors.textPrimary,
//                 ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null) {
//       onDateSelected(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         if (label != null) ...[
//           Text(
//             label!,
//             style: AppFonts.labelMedium,
//           ),
//           SizedBox(height: Spacing.xxs),
//         ],
//         InkWell(
//           onTap: disabled ? null : () => _showDatePicker(context),
//           child: InputDecorator(
//             decoration: InputDecoration(
//               errorText: error,
//               suffixIcon: Icon(Icons.calendar_today),
//               enabled: !disabled,
//             ),
//             child: Text(
//               selectedDate?.toString() ?? 'Select date',
//               style: AppFonts.bodyMedium.copyWith(
//                 color: selectedDate == null ? AppColors.textSecondary : null,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
