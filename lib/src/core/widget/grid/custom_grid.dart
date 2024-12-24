// lib/src/core/widget/grid/custom_grid.dart

import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
    this.padding = EdgeInsets.zero,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
    this.primary = false,
    super.key,
  });

  /// Creates a grid with even spacing on all sides
  factory CustomGrid.evenSpacing({
    required int itemCount,
    required Widget? Function(BuildContext context, int index) itemBuilder,
    required double spacing,
    int crossAxisCount = 3,
    double childAspectRatio = 1.0,
    ScrollPhysics physics = const NeverScrollableScrollPhysics(),
    bool shrinkWrap = true,
  }) {
    return CustomGrid(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      padding: EdgeInsets.all(spacing),
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }

  /// Number of items in the grid
  final int itemCount;

  /// Builder function for grid items
  final Widget? Function(BuildContext context, int index) itemBuilder;

  /// Number of items in each row
  final int crossAxisCount;

  /// Width to height ratio of items
  final double childAspectRatio;

  /// Horizontal spacing between items
  final double crossAxisSpacing;

  /// Vertical spacing between items
  final double mainAxisSpacing;

  /// Padding around the grid
  final EdgeInsetsGeometry padding;

  /// Scroll physics for the grid
  final ScrollPhysics physics;

  /// Whether the grid should shrink wrap its contents
  final bool shrinkWrap;

  /// Whether this is the primary scroll view
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      primary: primary,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
