import 'package:flutter/material.dart';
import 'package:rh_host/src/core/widget/drawer/app_drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    required this.items,
    this.header,
    this.footer,
    super.key,
  });

  final Widget? header;
  final List<AppDrawerItem> items;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          if (header != null) header!,
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => items[index],
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
