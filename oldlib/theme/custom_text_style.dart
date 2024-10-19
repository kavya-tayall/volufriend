import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get openSans {
    return copyWith(
      fontFamily: 'Open Sans',
    );
  }

  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get playfairDisplay {
    return copyWith(
      fontFamily: 'Playfair Display',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyLargeGray800 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray800,
      );
  static get bodyLargeInterGray400 => theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.gray400,
      );
  static get bodyLargeLightblue900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.lightBlue900,
      );
  static get bodyLargePoppinsGray80001 =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: appTheme.gray80001,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBlack900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBluegray700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray700,
      );
  static get bodyMediumGray800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray800,
      );
  static get bodyMediumInterSecondaryContainer =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: theme.colorScheme.secondaryContainer,
      );
  static get bodyMediumPlayfairDisplay =>
      theme.textTheme.bodyMedium!.playfairDisplay;
  static get bodyMediumPoppinsBlack900 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.87),
      );
  static get bodySmallGray90003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray90003,
        fontSize: 10.fSize,
      );
  static get bodySmallMontserratBlack900 =>
      theme.textTheme.bodySmall!.montserrat.copyWith(
        color: appTheme.black900.withOpacity(0.6),
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmallRobotoGray800 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.gray800,
      );
  static get bodySmallRobotoPrimary =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: theme.colorScheme.primary,
      );
// Headline text style
  static get headlineLargeOpenSansBlack900 =>
      theme.textTheme.headlineLarge!.openSans.copyWith(
        color: appTheme.black900,
        fontSize: 30.fSize,
        fontWeight: FontWeight.w600,
      );
  static get headlineLargePrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w900,
      );
  static get headlineLargeWhiteA700 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.whiteA700,
      );
  static get headlineSmallRobotoGray90003 =>
      theme.textTheme.headlineSmall!.roboto.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w400,
      );
// Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeOpenSansBlack900 =>
      theme.textTheme.titleLarge!.openSans.copyWith(
        color: appTheme.black900,
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray90003 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray90003,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray900Medium => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumMontserrat => theme.textTheme.titleMedium!.montserrat;
  static get titleMediumMontserratBlack900 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.black900.withOpacity(0.87),
      );
  static get titleMediumMontserratBlack90018 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.black900.withOpacity(0.87),
        fontSize: 18.fSize,
      );
  static get titleMediumMontserratTeal900 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.teal900,
      );
  static get titleMediumPoppinsPrimary =>
      theme.textTheme.titleMedium!.poppins.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.38),
      );
  static get titleSmallBlack900_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBluegray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90002,
      );
  static get titleSmallBluegray90002Bold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray90002,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90002,
      );
  static get titleSmallGray90003 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90003.withOpacity(0.38),
      );
  static get titleSmallGray90003_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90003,
      );
  static get titleSmallLightblue90001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.lightBlue90001,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPrimary_1 => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallTeal900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.teal900,
      );
}
