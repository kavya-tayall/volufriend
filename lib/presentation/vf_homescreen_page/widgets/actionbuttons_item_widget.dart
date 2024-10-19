import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../models/actionbuttons_item_model.dart';

// ignore_for_file: must_be_immutable
class ActionbuttonsItemWidget extends StatelessWidget {
  ActionbuttonsItemWidget(this.actionbuttonsItemModelObj,
      {Key? key, required this.onPressed})
      : super(key: key);

  final ActionbuttonsItemModel actionbuttonsItemModelObj;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.h, // Fixed width for button
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: CustomIconButton(
              height: 50.h, // Reduced height for the icon button
              width: 50.h, // Reduced width for the icon button
              padding: EdgeInsets.all(8.h), // Adjusted padding for smaller size
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary, // Theme color
                borderRadius:
                    BorderRadius.circular(12), // Slightly smaller radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Soft shadow
                    blurRadius: 6, // Adjusted blur for subtlety
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CustomImageView(
                imagePath: actionbuttonsItemModelObj.iconButton!,
                fit: BoxFit.contain, // Fit the image within the button
              ),
              onTap: onPressed, // Handle tap action
            ),
          ),
          SizedBox(height: 6.h), // Adjusted space for better alignment
          Flexible(
            child: Text(
              actionbuttonsItemModelObj.text!,
              style: TextStyle(
                fontSize: 12, // Adjusted font size for balance
                fontWeight: FontWeight.w500, // Semi-bold for prominence
                color: Theme.of(context)
                    .colorScheme
                    .primary, // Text color from theme
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),
        ],
      ),
    );
  }
}
