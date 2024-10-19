import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_homescreen_container_model.dart';
part 'vf_homescreen_container_event.dart';
part 'vf_homescreen_container_state.dart';

/// A bloc that manages the state of a VfHomescreenContainer according to the event that is dispatched to it.
class VfHomescreenContainerBloc
    extends Bloc<VfHomescreenContainerEvent, VfHomescreenContainerState> {
  // Provide a default initial state
  VfHomescreenContainerBloc() : super(VfHomescreenContainerState()) {
    on<VfHomescreenContainerInitialEvent>(_onInitialize);
    on<SetEventIdInEditModeStarted>(_onSetEventIdInEditModeStarted);
    on<SetEventIdInEditModeEnded>(_onSetEventIdInEditModeEnded);
    on<SetEventIdInDetailsViewMode>(_onSetEventIdInDetailsViewMode);
    on<StartCreateModeEvent>(_onStartCreateMode);
    on<EndCreateModeEvent>(_onEndCreateMode);
  }

  void _onInitialize(
    VfHomescreenContainerInitialEvent event,
    Emitter<VfHomescreenContainerState> emit,
  ) {
    // Initialization logic if needed
    print("I am inside __onInitialize of VfHomescreenContainerBloc");
    emit(state.copyWith(
      eventId: '',
      eventIdInEditModeStarted: false,
      eventIdInEditModeEnded: false,
      eventIdInCreateModeStarted: false,
      eventIdInCreateModeEnded: false,
      eventIdInDetailsViewMode: false,
    ));
  }

  // Event handler for when edit mode is started
  void _onSetEventIdInEditModeStarted(SetEventIdInEditModeStarted event,
      Emitter<VfHomescreenContainerState> emit) {
    emit(state.copyWith(
      eventId: event.eventId,
      eventIdInEditModeStarted: true,
      eventIdInEditModeEnded: false,
      eventIdInCreateModeStarted: false,
      eventIdInCreateModeEnded: false,
      eventIdInDetailsViewMode: false,
    ));
  }

  // Event handler for when edit mode is ended
  void _onSetEventIdInEditModeEnded(SetEventIdInEditModeEnded event,
      Emitter<VfHomescreenContainerState> emit) {
    emit(state.copyWith(
      eventId: event.eventId,
      eventIdInEditModeEnded: true,
      eventIdInEditModeStarted: false,
      eventIdInCreateModeStarted: false,
      eventIdInCreateModeEnded: false,
      eventIdInDetailsViewMode: false,
    ));
  }

  // Event handler for when details view mode is set
  void _onSetEventIdInDetailsViewMode(SetEventIdInDetailsViewMode event,
      Emitter<VfHomescreenContainerState> emit) {
    print("I am inside _onSetEventIdInDetailsViewMode");
    print(event.eventId);

    emit(state.copyWith(
      eventIdInDetailsViewMode: true,
      eventIdInCreateModeStarted: false,
      eventIdInCreateModeEnded: false,
      eventIdInEditModeStarted: false,
      eventIdInEditModeEnded: false,
      eventId: event.eventId,
    ));
  }

  // Event handler for when create mode starts
  void _onStartCreateMode(
      StartCreateModeEvent event, Emitter<VfHomescreenContainerState> emit) {
    print("I am inside __onStartCreateModee");
    emit(state.copyWith(
      eventIdInCreateModeStarted: true,
      eventIdInCreateModeEnded: false,
      eventIdInEditModeStarted: false,
      eventIdInEditModeEnded: false,
      eventIdInDetailsViewMode: false,
      eventId: '', // Reset the eventId to blank
      forcestate: true,
    ));
  }

  // Event handler for when create mode ends
  void _onEndCreateMode(
      EndCreateModeEvent event, Emitter<VfHomescreenContainerState> emit) {
    emit(state.copyWith(
      eventIdInCreateModeEnded: true,
      eventIdInCreateModeStarted: false,
      eventIdInEditModeStarted: false,
      eventIdInEditModeEnded: false,
      eventIdInDetailsViewMode: false,
      eventId: event.eventId, // Set the eventId passed in the event
    ));
  }
}
