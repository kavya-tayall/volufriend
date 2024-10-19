import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_joinasscreen_model.dart';

part 'vf_joinasscreen_event.dart';
part 'vf_joinasscreen_state.dart';

/// A bloc that manages the state of a VfJoinasscreen according to the event that is dispatched to it.
class VfJoinasscreenBloc
    extends Bloc<VfJoinasscreenEvent, VfJoinasscreenState> {
  VfJoinasscreenBloc(VfJoinasscreenState initialState) : super(initialState) {
    on<VfJoinasscreenInitialEvent>(_onInitialize);
    on<JoinAsVolunteerEvent>(_onJoinAsVolunteer);
    on<JoinAsOrganizationEvent>(_onJoinAsOrganization);
  }

  Future<void> _onInitialize(
    VfJoinasscreenInitialEvent event,
    Emitter<VfJoinasscreenState> emit,
  ) async {
    final model = state.vfJoinasscreenModelObj;

    if (model == null) {
      emit(VfJoinasscreenState(
        vfJoinasscreenModelObj: VfJoinasscreenModel(
            joinAs: ''), // Set a default model with empty joinAs
      ));
    } else {
      if (model.joinAs == "Volunteer") {
        emit(JoinAsVolunteerState(vfJoinasscreenModelObj: model));
      } else if (model.joinAs == "Organization") {
        emit(JoinAsOrganizationState(vfJoinasscreenModelObj: model));
      } else {
        emit(VfJoinasscreenState(
            vfJoinasscreenModelObj: model)); // Handle unexpected values
      }
    }
  }

  Future<void> _onJoinAsVolunteer(
    JoinAsVolunteerEvent event,
    Emitter<VfJoinasscreenState> emit,
  ) async {
    final model = state.vfJoinasscreenModelObj?.copyWith(joinAs: "Volunteer");
    emit(JoinAsVolunteerState(vfJoinasscreenModelObj: model));
  }

  Future<void> _onJoinAsOrganization(
    JoinAsOrganizationEvent event,
    Emitter<VfJoinasscreenState> emit,
  ) async {
    final model =
        state.vfJoinasscreenModelObj?.copyWith(joinAs: "Organization");
    emit(JoinAsOrganizationState(vfJoinasscreenModelObj: model));
  }
}
