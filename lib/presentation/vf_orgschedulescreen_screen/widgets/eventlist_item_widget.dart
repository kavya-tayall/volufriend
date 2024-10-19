import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/eventlist_item_model.dart';

// ignore_for_file: must_be_immutable
class EventlistItemWidget extends StatelessWidget {
  EventlistItemWidget(this.eventlistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  EventlistItemModel eventlistItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 12.h,
                  bottom: 4.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventlistItemModelObj.h3!,
                      style: CustomTextStyles.titleSmallGray900,
                    ),
                    Text(
                      eventlistItemModelObj.h3One!,
                      style: CustomTextStyles.titleMediumGray900Medium,
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eventlistItemModelObj.access!,
                                  style: CustomTextStyles
                                      .bodyMediumPlayfairDisplay,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  eventlistItemModelObj.h3Two!,
                                  style: theme.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventlistItemModelObj.accessOne!,
                                style:
                                    CustomTextStyles.bodyMediumPlayfairDisplay,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                eventlistItemModelObj.h3Three!,
                                style: theme.textTheme.bodyMedium,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            eventlistItemModelObj.h3Four!,
            style: CustomTextStyles.headlineLargePrimary,
          )
        ],
      ),
    );
  }
}
