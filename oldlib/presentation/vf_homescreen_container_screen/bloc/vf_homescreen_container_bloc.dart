import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_homescreen_container_model.dart';
part 'vf_homescreen_container_event.dart';
part 'vf_homescreen_container_state.dart';

/// A bloc that manages the state of a VfHomescreenContainer according to the event that is dispatched to it.
class VfHomescreenContainerBloc
    extends Bloc<VfHomescreenContainerEvent, VfHomescreenContainerState> {
  VfHomescreenContainerBloc(VfHomescreenContainerState initialState)
      : super(initialState) {
    on<VfHomescreenContainerInitialEvent>(_onInitialize);
  }

  _onInitialize(
    VfHomescreenContainerInitialEvent event,
    Emitter<VfHomescreenContainerState> emit,
  ) async {}
}
