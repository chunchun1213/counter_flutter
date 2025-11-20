import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Text styles for the Counter App.
/// All typography is derived from Figma design specifications using Inter font.
class AppTextStyles {
  AppTextStyles._(); // Private constructor to prevent instantiation

  /// Title text style - 16px Inter Regular for "計數器" label.
  static TextStyle get title => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.secondaryText,
    height: 1.5,
  );

  /// Counter display text style - 72px Inter Bold for the counter number.
  static TextStyle get counter => GoogleFonts.inter(
    fontSize: 72,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.darkPrimary,
    height: 1.2,
  );
}
