import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/userprofilelist_item_model.dart';
import '../models/vf_approvehoursscreen_model.dart';
part 'vf_approvehoursscreen_event.dart';
part 'vf_approvehoursscreen_state.dart';

/// A bloc that manages the state of a VfApprovehoursscreen according to the event that is dispatched to it.
class VfApprovehoursscreenBloc
    extends Bloc<VfApprovehoursscreenEvent, VfApprovehoursscreenState> {
  VfApprovehoursscreenBloc(VfApprovehoursscreenState initialState)
      : super(initialState) {
    on<VfApprovehoursscreenInitialEvent>(_onInitialize);
    on<UserprofilelistItemEvent>(_userprofilelistItem);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

  _userprofilelistItem(
    UserprofilelistItemEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<UserprofilelistItemModel> newList =
        List<UserprofilelistItemModel>.from(
            state.vfApprovehoursscreenModelObj!.userprofilelistItemList);
    newList[event.index] = newList[event.index].copyWith(
      isSelectedSwitch: event.isSelectedSwitch,
    );
    emit(state.copyWith(
        vfApprovehoursscreenModelObj: state.vfApprovehoursscreenModelObj
            ?.copyWith(userprofilelistItemList: newList)));
  }

  _changeSwitch(
    ChangeSwitchEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    emit(state.copyWith(
      isSelectedSwitch: event.value,
    ));
  }

  List<UserprofilelistItemModel> fillUserprofilelistItemList() {
    return [
      UserprofilelistItemModel(
          closeImage: ImageConstant.imgCloseIndigoA400,
          personName: "Alberto",
          orgName: "Bothell High School",
          hoursAttended: "10",
          subtitleText: "Approve"),
      UserprofilelistItemModel(),
      UserprofilelistItemModel()
    ];
  }

  _onInitialize(
    VfApprovehoursscreenInitialEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) async {
    emit(state.copyWith(
      searchController: TextEditingController(),
      isSelectedSwitch: false,
    ));
    emit(state.copyWith(
        vfApprovehoursscreenModelObj:
            state.vfApprovehoursscreenModelObj?.copyWith(
      userprofilelistItemList: fillUserprofilelistItemList(),
    )));
  }
}
