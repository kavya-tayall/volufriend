import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import '../core/app_export.dart';
import '../core/utils/validation_functions.dart';

// ignore_for_file: must_be_immutable
class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber(
      {Key? key,
      required this.country,
      required this.onTap,
      required this.controller})
      : super(
          key: key,
        );

  Country country;

  Function(Country) onTap;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.h,
        ),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.38),
          width: 1.h,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _openCountryPicker(context);
            },
            child: Row(
              children: [
                CountryPickerUtils.getDefaultFlagImage(
                  country,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowDown,
                  height: 20.h,
                  width: 20.h,
                  margin: EdgeInsets.only(left: 4.h),
                )
              ],
            ),
          ),
          Container(
            height: 36.h,
            width: 1.h,
            margin: EdgeInsets.only(left: 4.h),
            decoration: BoxDecoration(
              color: appTheme.black900.withOpacity(0.38),
            ),
          ),
          Expanded(
            child: Container(
              width: 240.h,
              margin: EdgeInsets.only(left: 6.h),
              child: TextFormField(
                focusNode: FocusNode(),
                autofocus: true,
                controller: controller,
                style: CustomTextStyles.titleSmallBlack900,
                decoration: InputDecoration(
                  hintText: "lbl_9898989898".tr,
                  hintStyle: CustomTextStyles.titleSmallBlack900,
                  border: InputBorder.none,
                  suffixIcon: Container(
                    margin: EdgeInsets.only(
                      left: 10.h,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgRightIcon,
                      height: 14.h,
                      width: 14.h,
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 36.h,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                validator: (value) {
                  if (!isValidPhone(value)) {
                    return "err_msg_please_enter_valid_phone_number";
                  }
                  return null;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          Container(
            margin: EdgeInsets.only(
              left: 10.h,
            ),
            width: 60.h,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(fontSize: 14.fSize),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              country.name,
              style: TextStyle(fontSize: 14.fSize),
            ),
          )
        ],
      );
  void _openCountryPicker(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(fontSize: 14.fSize),
          ),
          isSearchable: true,
          title: Text('Select your phone code',
              style: TextStyle(fontSize: 14.fSize)),
          onValuePicked: (Country country) => onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      );
}
