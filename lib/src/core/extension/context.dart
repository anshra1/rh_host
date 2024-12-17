// Flutter imports:
import 'package:flutter/material.dart';
import 'package:rh_host/src/core/design_system/app_font.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get size => mediaQuery.size;
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  TextStyle get displayLarge => theme.textTheme.displayLarge!;
  TextStyle get displayMedium => theme.textTheme.displayMedium!;
  TextStyle get displaySmall => theme.textTheme.displaySmall!;
  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;
  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;
  TextStyle get labelLarge => theme.textTheme.labelLarge!;
  TextStyle get labelMedium => theme.textTheme.labelMedium!;
  TextStyle get labelSmall => theme.textTheme.labelSmall!;
  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;
  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;
  TextStyle get bodySmall => theme.textTheme.bodySmall!;
  TextStyle get dialogTitle => AppFonts.dialogTitle(this);
  TextStyle get dialogButton => AppFonts.dialogButton(this);
}
