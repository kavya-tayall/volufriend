import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../core/app_export.dart';

// ignore_for_file: must_be_immutable
class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField(
      {Key? key,
      required this.context,
      required this.onChanged,
      this.alignment,
      this.controller,
      this.textStyle,
      this.hintStyle,
      this.validator})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget)
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 4,
        keyboardType: TextInputType.number,
        textStyle: textStyle ?? CustomTextStyles.bodySmallBlack900,
        hintStyle: hintStyle ?? CustomTextStyles.bodySmallBlack900,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enableActiveFill: true,
        pinTheme: PinTheme(
          fieldHeight: 36.h,
          fieldWidth: 34.h,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(3.h),
          inactiveColor: appTheme.indigo500,
          activeColor: appTheme.indigo500,
          inactiveFillColor: appTheme.cyan50,
          activeFillColor: appTheme.cyan50,
          selectedColor: appTheme.indigo500,
          selectedFillColor: appTheme.cyan50,
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
