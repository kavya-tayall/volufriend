import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_welcomescreen_model.dart';
part 'vf_welcomescreen_event.dart';
part 'vf_welcomescreen_state.dart';

/// A bloc that manages the state of a VfWelcomescreen according to the event that is dispatched to it.
class VfWelcomescreenBloc
    extends Bloc<VfWelcomescreenEvent, VfWelcomescreenState> {
  VfWelcomescreenBloc(VfWelcomescreenState initialState) : super(initialState) {
    on<VfWelcomescreenInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfWelcomescreenInitialEvent event,
    Emitter<VfWelcomescreenState> emit,
  ) async {}
}
