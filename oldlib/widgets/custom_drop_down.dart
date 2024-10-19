import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../data/models/selectionPopupModel/selection_popup_model.dart';

extension DropDownStyleHelper on CustomDropDown {
  static UnderlineInputBorder get underLineBlueGray => UnderlineInputBorder(
        borderSide: BorderSide(
          color: appTheme.blueGray90019,
        ),
      );
}

class CustomDropDown extends StatelessWidget {
  CustomDropDown(
      {Key? key,
      this.alignment,
      this.width,
      this.boxDecoration,
      this.focusNode,
      this.icon,
      this.autofocus = false,
      this.textStyle,
      this.hintText,
      this.hintStyle,
      this.items,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator,
      this.onChanged})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final BoxDecoration? boxDecoration;

  final FocusNode? focusNode;

  final Widget? icon;

  final bool? autofocus;

  final TextStyle? textStyle;

  final String? hintText;

  final TextStyle? hintStyle;

  final List<SelectionPopupModel>? items;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<SelectionPopupModel>? validator;

  final Function(SelectionPopupModel)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(alignment: alignment ?? Alignment.center, child: dropDownWidget)
        : dropDownWidget;
  }

  Widget get dropDownWidget => Container(
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: DropdownButtonFormField<SelectionPopupModel>(
          focusNode: focusNode,
          icon: icon,
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.titleLargeBlack900,
          hint: Text(
            hintText ?? "",
            style: hintStyle ?? CustomTextStyles.bodyLargeGray800,
          ),
          items: items?.map((SelectionPopupModel item) {
            return DropdownMenuItem<SelectionPopupModel>(
              value: item,
              child: Text(
                item.title,
                overflow: TextOverflow.ellipsis,
                style: hintStyle ?? CustomTextStyles.bodyLargeGray800,
              ),
            );
          }).toList(),
          decoration: decoration,
          validator: validator,
          onChanged: (value) {
            onChanged!(value!);
          },
        ),
      );
  InputDecoration get decoration => InputDecoration(
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 18.h,
            ),
        fillColor: fillColor ?? theme.colorScheme.primary,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
        focusedBorder: (borderDecoration ?? OutlineInputBorder()).copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1,
          ),
        ),
      );
}
