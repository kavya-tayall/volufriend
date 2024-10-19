import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_onboarding_2_model.dart';
part 'vf_onboarding_2_event.dart';
part 'vf_onboarding_2_state.dart';

/// A bloc that manages the state of a VfOnboarding2 according to the event that is dispatched to it.
class VfOnboarding2Bloc extends Bloc<VfOnboarding2Event, VfOnboarding2State> {
  VfOnboarding2Bloc(VfOnboarding2State initialState) : super(initialState) {
    on<VfOnboarding2InitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfOnboarding2InitialEvent event,
    Emitter<VfOnboarding2State> emit,
  ) async {
    // Delay navigation to VfOnboarding3Screen
    await Future.delayed(const Duration(seconds: 5));
    NavigatorService.popAndPushNamed(AppRoutes.vfOnboarding3Screen);
  }
}
