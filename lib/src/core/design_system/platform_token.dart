import 'dart:io';
import 'package:flutter/material.dart';

abstract class PlatformTokens {
  // iOS specific
  static const double iOSStatusBarHeight = 44;
  static const double iOSNavigationBarHeight = 44;
  static const double iOSTabBarHeight = 49;

  // Android specific
  static const double androidStatusBarHeight = 24;
  static const double androidNavigationBarHeight = 56;
  static const double androidBottomNavigationHeight = 56;

  // Platform-specific borders
  static BorderRadius get platformBorderRadius =>
      Platform.isIOS ? BorderRadius.circular(8) : BorderRadius.circular(4);
}
