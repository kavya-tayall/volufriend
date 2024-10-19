import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_createorgscreen_model.dart';
part 'vf_createorgscreen_event.dart';
part 'vf_createorgscreen_state.dart';

/// A bloc that manages the state of a VfCreateorgscreen according to the event that is dispatched to it.
class VfCreateorgscreenBloc
    extends Bloc<VfCreateorgscreenEvent, VfCreateorgscreenState> {
  VfCreateorgscreenBloc(VfCreateorgscreenState initialState)
      : super(initialState) {
    on<VfCreateorgscreenInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<VfCreateorgscreenState> emit,
  ) {
    emit(state.copyWith(
      isSchoolCheckbox: event.value,
    ));
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
    VfCreateorgscreenInitialEvent event,
    Emitter<VfCreateorgscreenState> emit,
  ) async {
    emit(state.copyWith(
      orgNameInputController: TextEditingController(),
      orgAddressInputController: TextEditingController(),
      orgEmailInputController: TextEditingController(),
      orgPhoneInputController: TextEditingController(),
      orgWebsiteInputController: TextEditingController(),
      isSchoolCheckbox: false,
    ));
    emit(state.copyWith(
        vfCreateorgscreenModelObj: state.vfCreateorgscreenModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
    )));
  }
}
