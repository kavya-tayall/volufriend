import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/actionbuttons_item_model.dart';
import '../models/upcomingeventslist_item_model.dart';
import '../models/vf_homescreen_model.dart';
part 'vf_homescreen_event.dart';
part 'vf_homescreen_state.dart';

/// A bloc that manages the state of a VfHomescreen according to the event that is dispatched to it.
class VfHomescreenBloc extends Bloc<VfHomescreenEvent, VfHomescreenState> {
  VfHomescreenBloc(VfHomescreenState initialState) : super(initialState) {
    on<VfHomescreenInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfHomescreenInitialEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    emit(state.copyWith(
        vfHomescreenModelObj: state.vfHomescreenModelObj?.copyWith(
      upcomingeventslistItemList: fillUpcomingeventslistItemList(),
      actionbuttonsItemList: fillActionbuttonsItemList(),
    )));
  }

  List<UpcomingeventslistItemModel> fillUpcomingeventslistItemList() {
    return [
      UpcomingeventslistItemModel(
          listItemHeadlin: "List item",
          listItemSupport:
              "Supporting line text lorem ipsum dolor sit amet, consectetur."),
      UpcomingeventslistItemModel(
          listItemHeadlin: "List item",
          listItemSupport:
              "Supporting line text lorem ipsum dolor sit amet, consectetur."),
      UpcomingeventslistItemModel()
    ];
  }

  List<ActionbuttonsItemModel> fillActionbuttonsItemList() {
    return [
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgGroup104, text: "Create Event"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgBookmarkWhiteA700, text: "Manage Event"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgCheckmarkWhiteA700,
          text: "Approve Hours")
    ];
  }
}
