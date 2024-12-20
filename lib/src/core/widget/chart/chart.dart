// // lib/src/design/components/charts/app_line_chart.dart

// // Package imports:
// import 'package:fl_chart/fl_chart.dart';

// class AppLineChart extends StatelessWidget {
//   const AppLineChart({
//     required this.data,
//     required this.xAxisLabels,
//     this.title,
//     this.height = 300,
//     this.showDots = true,
//     this.showArea = true,
//     this.lineColor,
//     this.areaColor,
//     this.dotColor,
//     super.key,
//   });

//   final List<double> data;
//   final List<String> xAxisLabels;
//   final String? title;
//   final double height;
//   final bool showDots;
//   final bool showArea;
//   final Color? lineColor;
//   final Color? areaColor;
//   final Color? dotColor;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null) ...[
//             Text(
//               title!,
//               style: AppFonts.titleMedium,
//             ),
//             SizedBox(height: Spacing.md),
//           ],
//           Expanded(
//             child: LineChart(
//               LineChartData(
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: List.generate(
//                       data.length,
//                       (i) => FlSpot(i.toDouble(), data[i]),
//                     ),
//                     isCurved: true,
//                     color: lineColor ?? AppColors.primaryColor,
//                     dotData: FlDotData(show: showDots),
//                     belowBarData: BarAreaData(
//                       show: showArea,
//                       color: areaColor ?? AppColors.primaryColor.withOpacity(0.1),
//                     ),
//                   ),
//                 ],
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index < 0 || index >= xAxisLabels.length) {
//                           return const SizedBox();
//                         }
//                         return Text(
//                           xAxisLabels[index],
//                           style: AppFonts.labelSmall,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawHorizontalLine: true,
//                   drawVerticalLine: false,
//                 ),
//                 borderData: FlBorderData(show: false),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // lib/src/design/components/charts/app_bar_chart.dart
// class AppBarChart extends StatelessWidget {
//   const AppBarChart({
//     required this.data,
//     required this.labels,
//     this.title,
//     this.height = 300,
//     this.barColor,
//     this.spacing = 12.0,
//     super.key,
//   });

//   final List<double> data;
//   final List<String> labels;
//   final String? title;
//   final double height;
//   final Color? barColor;
//   final double spacing;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null) ...[
//             Text(
//               title!,
//               style: AppFonts.titleMedium,
//             ),
//             S// Continuing AppBarChart...
//             SizedBox(height: Spacing.md),
//           ],
//           Expanded(
//             child: BarChart(
//               BarChartData(
//                 barGroups: List.generate(
//                   data.length,
//                   (i) => BarChartGroupData(
//                     x: i,
//                     barRods: [
//                       BarChartRodData(
//                         toY: data[i],
//                         color: barColor ?? AppColors.primaryColor,
//                         width: 16,
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(AppSize.radiusSM),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index < 0 || index >= labels.length) {
//                           return const SizedBox();
//                         }
//                         return Text(
//                           labels[index],
//                           style: AppFonts.labelSmall,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawHorizontalLine: true,
//                   drawVerticalLine: false,
//                 ),
//                 borderData: FlBorderData(show: false),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // lib/src/design/components/charts/app_pie_chart.dart
// class AppPieChart extends StatelessWidget {
//   const AppPieChart({
//     required this.data,
//     required this.labels,
//     this.colors,
//     this.title,
//     this.height = 300,
//     this.showLabels = true,
//     this.showValues = true,
//     super.key,
//   });

//   final List<double> data;
//   final List<String> labels;
//   final List<Color>? colors;
//   final String? title;
//   final double height;
//   final bool showLabels;
//   final bool showValues;

//   List<Color> get _colors => colors ?? [
//     AppColors.primaryColor,
//     AppColors.secondary,
//     AppColors.success,
//     AppColors.warning,
//     AppColors.error,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final total = data.reduce((a, b) => a + b);

//     return SizedBox(
//       height: height,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null) ...[
//             Text(
//               title!,
//               style: AppFonts.titleMedium,
//             ),
//             SizedBox(height: Spacing.md),
//           ],
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: PieChart(
//                     PieChartData(
//                       sections: List.generate(
//                         data.length,
//                         (i) => PieChartSectionData(
//                           value: data[i],
//                           title: showValues 
//                               ? '${(data[i] / total * 100).toStringAsFixed(1)}%'
//                               : '',
//                           color: _colors[i % _colors.length],
//                           radius: 100,
//                           titleStyle: AppFonts.labelSmall.copyWith(
//                             color: AppColors.textInverse,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (showLabels) ...[
//                   SizedBox(width: Spacing.md),
//                   SizedBox(
//                     width: 120,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: List.generate(
//                         data.length,
//                         (i) => Padding(
//                           padding: EdgeInsets.only(
//                             bottom: i < data.length - 1 
//                                 ? Spacing.sm 
//                                 : 0,
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 12,
//                                 height: 12,
//                                 decoration: BoxDecoration(
//                                   color: _colors[i % _colors.length],
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               SizedBox(width: Spacing.xs),
//                               Expanded(
//                                 child: Text(
//                                   labels[i],
//                                   style: AppFonts.labelSmall,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // lib/src/design/components/charts/app_donut_chart.dart
// class AppDonutChart extends StatelessWidget {
//   const AppDonutChart({
//     required this.data,
//     required this.labels,
//     this.colors,
//     this.title,
//     this.height = 300,
//     this.thickness = 20,
//     this.showLabels = true,
//     this.showValues = true,
//     super.key,
//   });

//   final List<double> data;
//   final List<String> labels;
//   final List<Color>? colors;
//   final String? title;
//   final double height;
//   final double thickness;
//   final bool showLabels;
//   final bool showValues;

//   List<Color> get _colors => colors ?? [
//     AppColors.primaryColor,
//     AppColors.secondary,
//     AppColors.success,
//     AppColors.warning,
//     AppColors.error,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final total = data.reduce((a, b) => a + b);

//     return SizedBox(
//       height: height,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null) ...[
//             Text(
//               title!,
//               style: AppFonts.titleMedium,
//             ),
//             SizedBox(height: Spacing.md),
//           ],
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       PieChart(
//                         PieChartData(
//                           sections: List.generate(
//                             data.length,
//                             (i) => PieChartSectionData(
//                               value: data[i],
//                               title: showValues 
//                                   ? '${(data[i] / total * 100).toStringAsFixed(1)}%'
//                                   : '',
//                               color: _colors[i % _colors.length],
//                               radius: 100,
//                               titleStyle: AppFonts.labelSmall.copyWith(
//                                 color: AppColors.textInverse,
//                               ),
//                             ),
//                           ),
//                           sectionsSpace: 0,
//                           centerSpaceRadius: 40,
//                         ),
//                       ),
//                       Center(
//                         child: Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: AppColors.surface,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Center(
//                             child: Text(
//                               total.toStringAsFixed(0),
//                               style: AppFonts.headlineSmall,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (showLabels) ...[
//                   SizedBox(width: Spacing.md),
//                   SizedBox(
//                     width: 120,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: List.generate(
//                         data.length,
//                         (i) => Padding(
//                           padding: EdgeInsets.only(
//                             bottom: i < data.length - 1 
//                                 ? Spacing.sm 
//                                 : 0,
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 12,
//                                 height: 12,
//                                 decoration: BoxDecoration(
//                                   color: _colors[i % _colors.length],
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               SizedBox(width: Spacing.xs),
//                               Expanded(
//                                 child: Text(
//                                   labels[i],
//                                   style: AppFonts.labelSmall,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
