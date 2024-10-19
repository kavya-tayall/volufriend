import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_createeventscreen3_eventadditionaldetails_model.dart';
part 'vf_createeventscreen3_eventadditionaldetails_event.dart';
part 'vf_createeventscreen3_eventadditionaldetails_state.dart';

/// A bloc that manages the state of a VfCreateeventscreen3Eventadditionaldetails according to the event that is dispatched to it.
class VfCreateeventscreen3EventadditionaldetailsBloc extends Bloc<
    VfCreateeventscreen3EventadditionaldetailsEvent,
    VfCreateeventscreen3EventadditionaldetailsState> {
  VfCreateeventscreen3EventadditionaldetailsBloc(
      VfCreateeventscreen3EventadditionaldetailsState initialState)
      : super(initialState) {
    on<VfCreateeventscreen3EventadditionaldetailsInitialEvent>(_onInitialize);
    on<ChangeCountryEvent>(_changeCountry);
  }

  _changeCountry(
    ChangeCountryEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) {
    emit(state.copyWith(
      selectedCountry: event.value,
    ));
  }

  _onInitialize(
    VfCreateeventscreen3EventadditionaldetailsInitialEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) async {
    emit(state.copyWith(
      additionalDetailsTextAreaController: TextEditingController(),
      nofilechosenvalController: TextEditingController(),
      coordinatorNameInputController: TextEditingController(),
      coordinatorEmailInputController: TextEditingController(),
      coordinatorPhoneInputController: TextEditingController(),
      phoneNumberController: TextEditingController(),
    ));
  }
}
