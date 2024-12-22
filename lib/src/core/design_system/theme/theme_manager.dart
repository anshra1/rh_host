import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rh_host/src/core/design_system/theme/theme_provider.dart';
import 'package:rh_host/src/core/design_system/theme/theme_switcher.dart';
import 'package:rh_host/src/core/design_system/theme/type_theme/dark_theme.dart';
import 'package:rh_host/src/core/design_system/theme/type_theme/light_theme.dart';
import 'package:rh_host/src/core/design_system/theme/type_theme/seed_theme.dart';

class ThemeManager extends StatelessWidget {
  const ThemeManager({
    required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
    super.key,
  });

  final Widget child;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: _ThemedApp(
        animationDuration: animationDuration,
        child: child,
      ),
    );
  }
}

class _ThemedApp extends StatelessWidget {
  const _ThemedApp({
    required this.child,
    required this.animationDuration,
  });

  final Widget child;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    
    final theme = themeProvider.useSeedColors
        ? themeProvider.isDarkMode 
            ? SeedTheme.darkTheme 
            : SeedTheme.lightTheme
        : themeProvider.isDarkMode 
            ? DarkTheme.theme 
            : LightTheme.theme;

    return AnimatedThemeSwitcher(
      duration: animationDuration,
      child: Theme(
        data: theme,
        child: child,
      ),
    );
  }
}
