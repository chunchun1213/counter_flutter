import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design theme constants for the Counter App.
/// Includes dimensions, shadows, and gradients derived from Figma specifications.
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  // Dimensions
  static const double cardWidth = 320;
  static const double cardHeight = 372;
  static const double cardBorderRadius = 16;
  static const double buttonSize = 64;
  static const double standardPadding = 16;
  static const double mediumPadding = 24;
  static const double largePadding = 48;

  // Card shadows - double layer shadow effect
  static final List<BoxShadow> cardShadows = [
    BoxShadow(
      color: const Color(0x1F000000), // Darker shadow below
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0x0D000000), // Lighter shadow above
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // Gradient background
  static final LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.lightBackground, AppColors.secondaryBackground],
  );
}
