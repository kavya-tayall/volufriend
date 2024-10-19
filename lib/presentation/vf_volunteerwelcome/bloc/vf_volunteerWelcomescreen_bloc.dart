import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_volunteerWelcomescreen_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../../auth/bloc/login_user_bloc.dart';
part 'vf_volunteerWelcomescreen_event.dart';
part 'vf_volunteerWelcomescreen_state.dart';

/// A bloc that manages the state of the VfVolunteerWelcome screen according to the event that is dispatched to it.
class VfvolunteerWelcomescreenBloc
    extends Bloc<VfvolunteerWelcomescreenEvent, VfvolunteerWelcomescreenState> {
  VfvolunteerWelcomescreenBloc(VfvolunteerWelcomescreenState initialState)
      : super(initialState) {
    on<VfVolunteerWelcomeInitialEvent>(_onInitialize);
  }

  Future<void> _onInitialize(
    VfVolunteerWelcomeInitialEvent event,
    Emitter<VfvolunteerWelcomescreenState> emit,
  ) async {
    // Copy the global LoginUser model to the screen model
    final loginUser = event.globalLoginUser;

    // Determine if the user is in the NoHomeOrg state
    final isNoHomeOrgState = event.globalUserState is NoHomeOrg;

    emit(VfvolunteerWelcomescreenState(
      vfvolunteerWelcomescreenModelObj:
          state.vfvolunteerWelcomescreenModelObj.copyWith(
        loginUser: loginUser,
      ),
      isNoHomeOrgState:
          isNoHomeOrgState, // Update state with the NoHomeOrg check
    ));
  }
}
