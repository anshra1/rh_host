// lib/src/design/tokens/motion_tokens.dart
import 'package:flutter/material.dart';

/// Design tokens for animation and motion
abstract class MotionTokens {
  // Durations
  static const Duration durationXS = Duration(milliseconds: 100);
  static const Duration durationSM = Duration(milliseconds: 200);
  static const Duration durationMD = Duration(milliseconds: 300);
  static const Duration durationLG = Duration(milliseconds: 400);
  static const Duration durationXL = Duration(milliseconds: 500);

  // Curves
  static const Curve standard = Curves.easeInOut;
  static const Curve standardAccelerate = Curves.easeIn;
  static const Curve standardDecelerate = Curves.easeOut;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve emphasizedAccelerate = Curves.easeInCubic;
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;

  // Page transitions
  // static  PageTransitionsBuilder slideTransition = 
  //   (context, animation, secondaryAnimation, child) =>
  //     SlideTransition(
  //       position: Tween<Offset>(
  //         begin: const Offset(1, 0),
  //         end: Offset.zero,
  //       ).animate(animation),
  //       child: child,
  //     );

  // static const PageTransitionsBuilder fadeTransition = 
  //   (context, animation, secondaryAnimation, child) =>
  //     FadeTransition(
  //       opacity: animation,
  //       child: child,
  //     );

  // static const PageTransitionsBuilder scaleTransition = 
  //   (context, animation, secondaryAnimation, child) =>
  //     ScaleTransition(
  //       scale: Tween<double>(
  //         begin: 0.8,
  //         end: 1,
  //       ).animate(
  //         CurvedAnimation(
  //           parent: animation,
  //           curve: Curves.easeOut,
  //         ),
  //       ),
  //       child: child,
  //     );
}