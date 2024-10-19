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
  CustomDropDown({
    Key? key,
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
    this.onChanged,
    this.dropdownColor, // Added dropdownColor
    this.menuMaxHeight, // Added menuMaxHeight
    this.isDense, // Added isDense
    this.onTap, // Added onTap
    this.initialValue, // Added initialValue
  }) : super(key: key);

  final Alignment? alignment;
  final double? width;
  final BoxDecoration? boxDecoration;
  final FocusNode? focusNode;
  final Widget? icon;
  final bool autofocus;
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
  final bool filled;
  final FormFieldValidator<SelectionPopupModel>? validator;
  final Function(SelectionPopupModel)? onChanged;
  final Color? dropdownColor; // New property
  final double? menuMaxHeight; // New property
  final bool? isDense; // New property
  final VoidCallback? onTap; // New property
  final SelectionPopupModel? initialValue; // New property

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
          autofocus: autofocus,
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
            if (onChanged != null) {
              onChanged!(value!);
            }
          },
          dropdownColor: dropdownColor, // Apply new property
          menuMaxHeight: menuMaxHeight, // Apply new property
          isDense: isDense ?? true, // Apply new property
          onTap: onTap, // Apply new property
          value: initialValue, // Apply new property
        ),
      );

  InputDecoration get decoration => InputDecoration(
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: isDense ?? true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 18.h,
            ),
        fillColor: fillColor ?? theme.colorScheme.surface,
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
