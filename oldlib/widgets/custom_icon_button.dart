import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(36.h),
      );
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.black900,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlackTL12 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.49),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.49),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlackTL16 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(
          color: appTheme.black900,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlackTL161 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.49),
        borderRadius: BorderRadius.circular(16.h),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.49),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlackTL20 => BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: appTheme.black900,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineBlackTL201 => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.49),
        borderRadius: BorderRadius.circular(20.h),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.49),
          width: 1.h,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        color: appTheme.whiteA700.withOpacity(0.49),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.49),
          width: 1.h,
        ),
      );
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.decoration,
      this.padding,
      this.onTap,
      this.child})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final BoxDecoration? decoration;

  final EdgeInsetsGeometry? padding;

  final VoidCallback? onTap;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: DecoratedBox(
          decoration: decoration ??
              BoxDecoration(
                color: appTheme.gray90002,
                borderRadius: BorderRadius.circular(14.h),
              ),
          child: IconButton(
            padding: padding ?? EdgeInsets.zero,
            onPressed: onTap,
            icon: child ?? Container(),
          ),
        ),
      );
}
