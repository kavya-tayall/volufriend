import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'package:flutter/services.dart'; // Import this for inputFormatters

extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlinePrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.h),
        borderSide: BorderSide(
          color:
              theme.colorScheme.primary, // Light grey border for default state
          width: 1.5,
        ),
      );
  static OutlineInputBorder get outlinePrimaryTL5 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.h),
        borderSide: BorderSide(
          color: theme.colorScheme.primary,
          width: 1,
        ),
      );
  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: BorderSide(
      color: Colors.red,
      width: 2.0,
    ),
  );
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.boxDecoration,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.suffixIcon, // Add this line
    this.inputFormatters, // Make this optional
    this.enabledBorderDecoration,
    this.focusedBorderDecoration,
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final TextEditingController? scrollPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon; // Add this line
  final List<TextInputFormatter>? inputFormatters; // Make this optional
  final InputBorder? enabledBorderDecoration;
  final InputBorder? focusedBorderDecoration;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context))
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: controller,
        focusNode: focusNode,
        onTapOutside: (event) {
          if (focusNode != null) {
            focusNode?.unfocus();
          } else {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        autofocus: autofocus!,
        style: textStyle ?? CustomTextStyles.titleSmallBlack900,
        obscureText: obscureText!,
        readOnly: readOnly!,
        onTap: () {
          onTap?.call();
        },
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: decoration,
        validator: validator,
        inputFormatters: inputFormatters, // Add this line
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyLargeGray800,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffixIcon, // Use suffixIcon here
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
        fillColor: fillColor ?? appTheme.whiteA700,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.h),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
        enabledBorder: enabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.h),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
        focusedBorder: focusedBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.h),
              borderSide: BorderSide(
                color: theme.colorScheme.secondary,
                width: 2,
              ),
            ),
        errorBorder: TextFormFieldStyleHelper.errorBorder,
        focusedErrorBorder: TextFormFieldStyleHelper.errorBorder.copyWith(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.5,
          ),
        ),
      );
}
