import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_onboarding_3_model.dart';
part 'vf_onboarding_3_event.dart';
part 'vf_onboarding_3_state.dart';

/// A bloc that manages the state of a VfOnboarding3 according to the event that is dispatched to it.
class VfOnboarding3Bloc extends Bloc<VfOnboarding3Event, VfOnboarding3State> {
  VfOnboarding3Bloc(VfOnboarding3State initialState) : super(initialState) {
    on<VfOnboarding3InitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfOnboarding3InitialEvent event,
    Emitter<VfOnboarding3State> emit,
  ) async {}
}
