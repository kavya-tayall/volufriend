import 'package:flutter/material.dart';
import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(
          width: 1,
        ),
        visualDensity: const VisualDensity(
          vertical: -4,
          horizontal: -4,
        ),
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        space: 1,
        color: appTheme.gray200,
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.gray90003,
          fontSize: 16.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray900,
          fontSize: 14.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.blueGray90002,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          color: appTheme.gray90003,
          fontSize: 32.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          color: appTheme.black900,
          fontSize: 24.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          color: appTheme.greenA100,
          fontSize: 12.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appTheme.gray800,
          fontSize: 11.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: appTheme.gray90003,
          fontSize: 22.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 16.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w700,
        ),
        titleSmall: TextStyle(
          color: appTheme.whiteA700,
          fontSize: 14.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFF0070BB),
    secondaryContainer: Color(0XFF555555),
    onPrimary: Color(0XFF011729),
    onPrimaryContainer: Color(0XFF519C78),
  );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
// BlueGray
  Color get blueGray100 => Color(0XFFCAC4D0);
  Color get blueGray10001 => Color(0XFFD9D9D9);
  Color get blueGray10002 => Color(0XFFCDD0D4);
  Color get blueGray200 => Color(0XFFB2B9C4);
  Color get blueGray700 => Color(0XFF535865);
  Color get blueGray900 => Color(0XFF323232);
  Color get blueGray90001 => Color(0XFF2C2C2C);
  Color get blueGray90002 => Color(0XFF333333);
  Color get blueGray90019 => Color(0X192B2B2B);
// Cyan
  Color get cyan50 => Color(0XFFD2F5FF);
  Color get cyan900 => Color(0XFF004A77);
// DeepPurple
  Color get deepPurpleA200 => Color(0XFF7B61FF);
// Gray
  Color get gray100 => Color(0XFFF7F2FA);
  Color get gray10001 => Color(0XFFF5F5F5);
  Color get gray200 => Color(0XFFEEEEEE);
  Color get gray20001 => Color(0XFFE8E8E8);
  Color get gray400 => Color(0XFFB3B3B3);
  Color get gray50 => Color(0XFFF7FBFF);
  Color get gray500 => Color(0XFF9F9F9F);
  Color get gray800 => Color(0XFF49454F);
  Color get gray80001 => Color(0XFF3B3B3B);
  Color get gray900 => Color(0XFF1B1C1E);
  Color get gray90001 => Color(0XFF1E1E1E);
  Color get gray90002 => Color(0XFF252525);
  Color get gray90003 => Color(0XFF1D1B20);
// Green
  Color get greenA100 => Color(0XFFB8FFCD);
// Indigo
  Color get indigo50 => Color(0XFFE1E6EC);
  Color get indigo500 => Color(0XFF3F5AA6);
  Color get indigo900 => Color(0XFF181A93);
  Color get indigoA400 => Color(0XFF3C61F2);
// LightBlue
  Color get lightBlue900 => Color(0XFF005093);
  Color get lightBlue90001 => Color(0XFF005A8C);
// Orange
  Color get orangeA200 => Color(0XFFFFA44A);
// Teal
  Color get teal900 => Color(0XFF00633B);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
}
