import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'actionbuttons_item_model.dart';
import 'upcomingeventslist_item_model.dart';

/// This class defines the variables used in the [vf_homescreen_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfHomescreenModel extends Equatable {
  VfHomescreenModel(
      {this.upcomingeventslistItemList = const [],
      this.actionbuttonsItemList = const []});

  List<UpcomingeventslistItemModel> upcomingeventslistItemList;

  List<ActionbuttonsItemModel> actionbuttonsItemList;

  VfHomescreenModel copyWith({
    List<UpcomingeventslistItemModel>? upcomingeventslistItemList,
    List<ActionbuttonsItemModel>? actionbuttonsItemList,
  }) {
    return VfHomescreenModel(
      upcomingeventslistItemList:
          upcomingeventslistItemList ?? this.upcomingeventslistItemList,
      actionbuttonsItemList:
          actionbuttonsItemList ?? this.actionbuttonsItemList,
    );
  }

  @override
  List<Object?> get props =>
      [upcomingeventslistItemList, actionbuttonsItemList];
}
