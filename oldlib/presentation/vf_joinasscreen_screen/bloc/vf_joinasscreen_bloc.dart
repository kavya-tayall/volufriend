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
  }

  _onInitialize(
    VfJoinasscreenInitialEvent event,
    Emitter<VfJoinasscreenState> emit,
  ) async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.vfWelcomescreenScreen,
      );
    });
  }
}
