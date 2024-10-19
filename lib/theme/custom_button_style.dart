import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray90003.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.h),
        ),
        elevation: 0,
      );
  static ButtonStyle get fillPrimaryTL12 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
        elevation: 0,
      );
  static ButtonStyle get fillWhiteA => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.h),
        ),
        elevation: 0,
      );
  static ButtonStyle get fillWhiteA1 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.whiteA700,
        elevation: 0,
      );
// text button style
  static ButtonStyle get none => ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      elevation: MaterialStateProperty.all<double>(0),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: Colors.transparent),
      ));
}
