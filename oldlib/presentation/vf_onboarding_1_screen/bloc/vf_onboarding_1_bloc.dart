import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_onboarding_1_model.dart';

part 'vf_onboarding_1_event.dart';
part 'vf_onboarding_1_state.dart';

/// A bloc that manages the state of a VfOnboarding1 according to the event that is dispatched to it.
class VfOnboarding1Bloc extends Bloc<VfOnboarding1Event, VfOnboarding1State> {
  VfOnboarding1Bloc(VfOnboarding1State initialState) : super(initialState) {
    on<VfOnboarding1InitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfOnboarding1InitialEvent event,
    Emitter<VfOnboarding1State> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 5)); // Wait for 3 seconds
    NavigatorService.pushNamed(AppRoutes.vfOnboarding2Screen);
  }
}
