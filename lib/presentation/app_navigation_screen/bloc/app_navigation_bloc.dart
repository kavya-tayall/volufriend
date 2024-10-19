import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/app_navigation_model.dart';
part 'app_navigation_event.dart';
part 'app_navigation_state.dart';

/// A bloc that manages the state of AppNavigation according to the event that is dispatched to it.
class AppNavigationBloc extends Bloc<AppNavigationEvent, AppNavigationState> {
  AppNavigationBloc(AppNavigationState initialState) : super(initialState) {
    on<AppNavigationInitialEvent>(_onInitialize);
    on<AppNavigationPushEvent>(_onDestination);
    on<AppNavigationPopEvent>(_onPop);
  }

  Future<void> _onPop(
    AppNavigationPopEvent event,
    Emitter<AppNavigationState> emit,
  ) async {
    emit(state.copyWith(
      sourceScreen: event.sourceScreen, // Pass the source screen to the state
    ));
  }

  Future<void> _onDestination(
    AppNavigationEvent event,
    Emitter<AppNavigationState> emit,
  ) async {
    if (event is AppNavigationPushEvent) {
      emit(state.copyWith(
        destinationScreen:
            event.destinationScreen, // Pass the destination screen to the state
      ));
    }
  }

  Future<void> _onInitialize(
    AppNavigationInitialEvent event,
    Emitter<AppNavigationState> emit,
  ) async {
    emit(state.copyWith(
      sourceScreen: event.sourceScreen, // Pass the source screen to the state
    ));
  }
}
