import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../models/actionbuttons_item_model.dart';

// ignore_for_file: must_be_immutable
class ActionbuttonsItemWidget extends StatelessWidget {
  ActionbuttonsItemWidget(this.actionbuttonsItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ActionbuttonsItemModel actionbuttonsItemModelObj;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.h,
      child: Column(
        children: [
          CustomIconButton(
            height: 72.h,
            width: 72.h,
            padding: EdgeInsets.all(16.h),
            decoration: IconButtonStyleHelper.fillPrimary,
            child: CustomImageView(
              imagePath: actionbuttonsItemModelObj.iconButton!,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            actionbuttonsItemModelObj.text!,
            style: CustomTextStyles.titleSmallGray90003_1,
          )
        ],
      ),
    );
  }
}
