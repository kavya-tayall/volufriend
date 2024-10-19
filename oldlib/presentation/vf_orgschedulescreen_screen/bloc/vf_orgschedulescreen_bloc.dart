import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_orgschedulescreen_model.dart';
part 'vf_orgschedulescreen_event.dart';
part 'vf_orgschedulescreen_state.dart';

/// A bloc that manages the state of a VfOrgschedulescreen according to the event that is dispatched to it.
class VfOrgschedulescreenBloc
    extends Bloc<VfOrgschedulescreenEvent, VfOrgschedulescreenState> {
  VfOrgschedulescreenBloc(VfOrgschedulescreenState initialState)
      : super(initialState) {
    on<VfOrgschedulescreenInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfOrgschedulescreenInitialEvent event,
    Emitter<VfOrgschedulescreenState> emit,
  ) async {}
}
