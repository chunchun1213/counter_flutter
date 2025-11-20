import 'package:flutter/material.dart';

/// Design tokens for the Counter App color palette.
/// All colors are derived from Figma design specifications.
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  /// Light background color used in gradient backgrounds.
  static const Color lightBackground = Color(0xFFEFF5FE);

  /// Secondary background color used in gradient backgrounds.
  static const Color secondaryBackground = Color(0xFFE0E7FF);

  /// Primary dark color for main UI elements.
  static const Color darkPrimary = Color(0xFF030213);

  /// White color for card containers and text.
  static const Color white = Color(0xFFFFFFFF);

  /// Secondary text color for descriptions and secondary elements.
  static const Color secondaryText = Color(0xFF364153);

  /// Accent text color for various UI elements.
  static const Color accentText = Color(0xFF101828);

  /// Button color - deep blue for floating action button.
  static const Color buttonBlue = Color(0xFF364153);
}
