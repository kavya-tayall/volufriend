import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_createeventscreen1_eventdetails_model.dart';
part 'vf_createeventscreen1_eventdetails_event.dart';
part 'vf_createeventscreen1_eventdetails_state.dart';

/// A bloc that manages the state of a VfCreateeventscreen1Eventdetails according to the event that is dispatched to it.
class VfCreateeventscreen1EventdetailsBloc extends Bloc<
    VfCreateeventscreen1EventdetailsEvent,
    VfCreateeventscreen1EventdetailsState> {
  VfCreateeventscreen1EventdetailsBloc(
      VfCreateeventscreen1EventdetailsState initialState)
      : super(initialState) {
    on<VfCreateeventscreen1EventdetailsInitialEvent>(_onInitialize);
    on<ChangeDateEvent>(_changeDate);
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
    VfCreateeventscreen1EventdetailsInitialEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) async {
    emit(state.copyWith(
      titleInputController: TextEditingController(),
      venueInputController: TextEditingController(),
      eventDateInputController: TextEditingController(),
      minimumAgeInputController: TextEditingController(),
      registrationDeadlineInputController: TextEditingController(),
    ));
    emit(state.copyWith(
        vfCreateeventscreen1EventdetailsModelObj:
            state.vfCreateeventscreen1EventdetailsModelObj?.copyWith(
      dropdownItemList: fillDropdownItemList(),
    )));
  }

  _changeDate(
    ChangeDateEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(
        vfCreateeventscreen1EventdetailsModelObj:
            state.vfCreateeventscreen1EventdetailsModelObj?.copyWith(
      selectedEventDateInput: event.date,
    )));
  }
}
