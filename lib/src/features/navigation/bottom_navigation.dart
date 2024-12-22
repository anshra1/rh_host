// Package imports:
import 'package:advanced_salomon_bottom_bar/advanced_salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rh_host/src/features/batch/import.dart';
import 'package:rh_host/src/features/services/presentation/pages/pages.dart';

class AppBottomNavigation extends HookWidget {
  const AppBottomNavigation(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        return null;

        // final subcription = FireStoreTaskStream.getTasksStream();
        // return subcription.cancel;
      },
      [],
    );
    return Scaffold(
      body: child,
      bottomNavigationBar: AdvancedSalomonBottomBar(
        items: _navigationItem,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onTap(context, index),
      ),
    );
  }
}

int _calculateSelectedIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();

  if (location.startsWith(HomePage.routeName)) {
    return 0;
  }

  if (location.startsWith(BatchPage.routeName)) {
    return 1;
  }
  if (location.startsWith(PaymentPage.routeName)) {
    return 2;
  }
  if (location.startsWith(BooksPage.routeName)) {
    return 3;
  }
  if (location.startsWith(ServicesPage.routeName)) {
    return 4;
  }
  return 0;
}

void _onTap(
  BuildContext context,
  int index,
) {
  switch (index) {
    case 0:
      context.go(HomePage.routeName);
    case 1:
      context.go(BatchPage.routeName);
    case 2:
      context.go(PaymentPage.routeName);
    case 3:
      context.go(BooksPage.routeName);
    case 4:
      context.go(ServicesPage.routeName);
    default:
      break;
  }
}

var _navigationItem = [
  AdvancedSalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text('Home'),
    selectedColor: Colors.purple,
  ),

  /// Likes
  AdvancedSalomonBottomBarItem(
    // ignore: deprecated_member_use
    icon: const Icon(FontAwesomeIcons.tasks),
    title: const Text('Batch'),
    selectedColor: Colors.purple,
  ),

  AdvancedSalomonBottomBarItem(
    icon: const Icon(Icons.book),
    title: const Text('Payment'),
    selectedColor: Colors.purple,
  ),

  AdvancedSalomonBottomBarItem(
    icon: const Icon(FontAwesomeIcons.user),
    title: const Text('Books'),
    selectedColor: Colors.pink,
  ),

  AdvancedSalomonBottomBarItem(
    icon: const Icon(FontAwesomeIcons.user),
    title: const Text('Sevices'),
    selectedColor: Colors.pink,
  ),
];
