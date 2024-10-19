import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/listtitlesmall_item_model.dart';

// ignore_for_file: must_be_immutable
class ListtitlesmallItemWidget extends StatelessWidget {
  ListtitlesmallItemWidget(this.listtitlesmallItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ListtitlesmallItemModel listtitlesmallItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176.h,
      padding: EdgeInsets.all(6.h),
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            listtitlesmallItemModelObj.titlesmall!,
            style: CustomTextStyles.titleSmallTeal900,
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 8.h,
              right: 10.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listtitlesmallItemModelObj.time!,
                  style: CustomTextStyles.titleSmallTeal900,
                ),
                SizedBox(width: 8.h),
                Text(
                  listtitlesmallItemModelObj.titlesmallOne!,
                  style: CustomTextStyles.titleSmallTeal900,
                ),
                SizedBox(width: 8.h),
                Text(
                  listtitlesmallItemModelObj.timeOne!,
                  style: CustomTextStyles.titleSmallTeal900,
                )
              ],
            ),
          ),
          SizedBox(height: 4.h)
        ],
      ),
    );
  }
}
