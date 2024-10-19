import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_switch.dart';
import '../models/userprofilelist_item_model.dart';

// ignore_for_file: must_be_immutable
class UserprofilelistItemWidget extends StatelessWidget {
  UserprofilelistItemWidget(this.userprofilelistItemModelObj,
      {Key? key, this.changeSwitch})
      : super(
          key: key,
        );

  UserprofilelistItemModel userprofilelistItemModelObj;

  Function(bool)? changeSwitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.surface,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: userprofilelistItemModelObj.closeImage!,
                  height: 24.h,
                  width: 24.h,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userprofilelistItemModelObj.personName!,
                            style: CustomTextStyles.titleMediumBlack900,
                          ),
                          Text(
                            userprofilelistItemModelObj.orgName!,
                            style: CustomTextStyles.bodyMediumBluegray700,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 8.h,
                  ),
                  child: Text(
                    userprofilelistItemModelObj.hoursAttended!,
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.h,
                    top: 10.h,
                  ),
                  child: Text(
                    userprofilelistItemModelObj.subtitleText!,
                    style: CustomTextStyles.bodyMediumInterSecondaryContainer,
                  ),
                ),
                CustomSwitch(
                  margin: EdgeInsets.only(
                    left: 8.h,
                    top: 4.h,
                  ),
                  value: userprofilelistItemModelObj.isSelectedSwitch!,
                  onChange: (value) {
                    changeSwitch?.call(value);
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              endIndent: 10.h,
            ),
          )
        ],
      ),
    );
  }
}
