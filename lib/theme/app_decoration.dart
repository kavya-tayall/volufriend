import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray90001,
      );
  static BoxDecoration get fillCyan => BoxDecoration(
        color: appTheme.cyan50,
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray10001,
      );
  static BoxDecoration get fillGray20001 => BoxDecoration(
        color: appTheme.gray20001,
      );
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo50,
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
  static BoxDecoration get outlineBlueGray => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.blueGray100,
            width: 1.h,
          ),
        ),
      );
// M decorations
  static BoxDecoration get m3ElevationLight1 => BoxDecoration(
        color: appTheme.gray100,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.15),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1,
            ),
          )
        ],
      );
// Materialyousysdarksecondarycontainer decorations
  static BoxDecoration get materialyousysdarksecondarycontainer =>
      BoxDecoration(
        color: appTheme.cyan900,
      );
// Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.07),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              -4,
              -4,
            ),
          )
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: appTheme.whiteA700,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.07),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              4,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        border: Border.all(
          color: appTheme.black900,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineCyan => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          bottom: BorderSide(
            color: appTheme.cyan50,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlineDeepPurpleA => BoxDecoration();
  static BoxDecoration get outlineGray => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.gray900,
            width: 1.h,
          ),
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1.h,
        ),
      );
// Surface decorations
  static BoxDecoration get surface => BoxDecoration(
        color: appTheme.whiteA700,
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder24 => BorderRadius.circular(
        24.h,
      );
// Custom borders
  static BorderRadius get customBorderTL28 => BorderRadius.only(
        topLeft: Radius.circular(28.h),
        topRight: Radius.circular(28.h),
        bottomLeft: Radius.circular(28.h),
        bottomRight: Radius.circular(16.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder5 => BorderRadius.circular(
        5.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}
