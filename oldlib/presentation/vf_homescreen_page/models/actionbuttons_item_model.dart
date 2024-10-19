import '../../../core/app_export.dart';

/// This class is used in the [actionbuttons_item_widget] screen.

// ignore_for_file: must_be_immutable
class ActionbuttonsItemModel {
  ActionbuttonsItemModel({this.iconButton, this.text, this.id}) {
    iconButton = iconButton ?? ImageConstant.imgGroup104;
    text = text ?? "Create Event";
    id = id ?? "";
  }

  String? iconButton;

  String? text;

  String? id;
}
