import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/upcomingeventslist_item_model.dart';

// ignore_for_file: must_be_immutable
class UpcomingeventslistItemWidget extends StatelessWidget {
  UpcomingeventslistItemWidget(this.upcomingeventslistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  UpcomingeventslistItemModel upcomingeventslistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.h, 12.h, 14.h, 10.h),
      decoration: AppDecoration.outlineCyan,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgThumbnail,
            height: 56.h,
            width: 56.h,
            radius: BorderRadius.circular(
              16.h,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    upcomingeventslistItemModelObj.listItemHeadlin!,
                    style: CustomTextStyles.bodyLargeLightblue900,
                  ),
                  Text(
                    upcomingeventslistItemModelObj.listItemSupport!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodyMediumBlack900_1.copyWith(
                      height: 1.43,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 16.h),
          CustomImageView(
            imagePath: ImageConstant.imgNotification,
            height: 24.h,
            width: 24.h,
          )
        ],
      ),
    );
  }
}
