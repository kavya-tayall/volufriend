import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_createeventscreen2_eventshifts_model.dart';
part 'vf_createeventscreen2_eventshifts_event.dart';
part 'vf_createeventscreen2_eventshifts_state.dart';

/// A bloc that manages the state of a VfCreateeventscreen2Eventshifts according to the event that is dispatched to it.
class VfCreateeventscreen2EventshiftsBloc extends Bloc<
    VfCreateeventscreen2EventshiftsEvent,
    VfCreateeventscreen2EventshiftsState> {
  VfCreateeventscreen2EventshiftsBloc(
      VfCreateeventscreen2EventshiftsState initialState)
      : super(initialState) {
    on<VfCreateeventscreen2EventshiftsInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfCreateeventscreen2EventshiftsInitialEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) async {
    emit(state.copyWith(
      shiftActivityInputController: TextEditingController(),
      shiftStartTimeController: TextEditingController(),
      shiftEndTimeController: TextEditingController(),
      shiftMaxParticipantsController: TextEditingController(),
      shiftActivityInput1Controller: TextEditingController(),
      shiftStartTime1Controller: TextEditingController(),
      shiftEndTime1Controller: TextEditingController(),
      shiftMaxParticipants1Controller: TextEditingController(),
    ));
  }
}
