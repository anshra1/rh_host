import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    required this.body,
    this.appBar,
    this.padding,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    super.key,
  });

  // Factory constructors for common use cases
  factory BaseScaffold.scrollable({
    required Widget body,
    PreferredSizeWidget? appBar,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(24),
    ScrollPhysics? physics,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
    bool resizeToAvoidBottomInset = true,
    Key? key,
  }) {
    return BaseScaffold(
      key: key,
      appBar: appBar,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: SingleChildScrollView(
        physics: physics,
        padding: padding,
        child: body,
      ),
    );
  }

  factory BaseScaffold.list({
    required Widget body,
    PreferredSizeWidget? appBar,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(24),
    ScrollPhysics? physics,
    Color? backgroundColor,
    Widget? bottomNavigationBar,
    Widget? floatingActionButton,
    bool resizeToAvoidBottomInset = true,
    Key? key,
  }) {
    return BaseScaffold(
      key: key,
      appBar: appBar,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: ListView(
        physics: physics,
        padding: padding,
        children: [body],
      ),
    );
  }

  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;

  @override
  Widget build(BuildContext context) {
    var content = body;
    if (padding != null) {
      content = Padding(
        padding: padding!,
        child: content,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: content,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
    );
  }
}
