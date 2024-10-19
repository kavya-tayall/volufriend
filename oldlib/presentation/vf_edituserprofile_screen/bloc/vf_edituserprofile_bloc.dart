import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_edituserprofile_model.dart';
part 'vf_edituserprofile_event.dart';
part 'vf_edituserprofile_state.dart';

/// A bloc that manages the state of a VfEdituserprofile according to the event that is dispatched to it.
class VfEdituserprofileBloc
    extends Bloc<VfEdituserprofileEvent, VfEdituserprofileState> {
  VfEdituserprofileBloc(VfEdituserprofileState initialState)
      : super(initialState) {
    on<VfEdituserprofileInitialEvent>(_onInitialize);
  }

  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }

  _onInitialize(
    VfEdituserprofileInitialEvent event,
    Emitter<VfEdituserprofileState> emit,
  ) async {
    emit(state.copyWith(
      firstNameFieldController: TextEditingController(),
      lastNameFieldController: TextEditingController(),
      emailFieldController: TextEditingController(),
      phoneNumberFieldController: TextEditingController(),
    ));
    emit(state.copyWith(
        vfEdituserprofileModelObj: state.vfEdituserprofileModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
    )));
  }
}
