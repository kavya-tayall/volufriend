import 'package:flutter/material.dart';
import '../../../core/app_export.dart'; // Assuming this imports necessary assets
import '../models/upcomingeventslist_item_model.dart';

class UpcomingeventslistItemWidget extends StatelessWidget {
  final UpcomingeventslistItemModel upcomingeventslistItemModelObj;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDismissed;
  final Widget? trailing; // Trailing widget as an optional parameter
  final Function(String, String)
      onMenuSelected; // Callback to handle menu actions with ID

  const UpcomingeventslistItemWidget({
    Key? key,
    required this.upcomingeventslistItemModelObj,
    required this.onTap,
    required this.onLongPress,
    required this.onDismissed,
    this.trailing, // Accept trailing widget
    required this.onMenuSelected, // Callback for menu actions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If the event is canceled, return an empty widget (or SizedBox.shrink())
    if (upcomingeventslistItemModelObj.isCanceled ?? true) {
      return SizedBox.shrink();
    }

    // If the event is not canceled, return the usual widget
    return Dismissible(
      key: Key(upcomingeventslistItemModelObj.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismissed(); // Trigger the swipe action callback
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: onTap, // Trigger tap action
        onLongPress: onLongPress, // Trigger long press action
        child: Container(
          padding: EdgeInsets.fromLTRB(14.h, 12.h, 14.h, 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.h),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgThumbnail,
                height: 56.h,
                width: 56.h,
                radius: BorderRadius.circular(16.h),
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.h),
              // Show the trailing widget if provided
              if (trailing != null) trailing!,
              // If no trailing widget is passed, display default PopupMenuButton
              if (trailing == null)
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    // Pass the selected value (e.g., edit, delete) and ID back to the parent widget
                    onMenuSelected(value, upcomingeventslistItemModelObj.id!);
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'cancel',
                      child: Text('Cancel'),
                    ),
                  ],
                  child: CustomImageView(
                    imagePath: ImageConstant.imgNotification,
                    height: 24.h,
                    width: 24.h,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
