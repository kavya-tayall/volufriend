import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/openhamburgermenuscreennew_model.dart';
part 'openhamburgermenuscreennew_event.dart';
part 'openhamburgermenuscreennew_state.dart';

/// A bloc that manages the state of a Openhamburgermenuscreennew according to the event that is dispatched to it.
class OpenhamburgermenuscreennewBloc extends Bloc<
    OpenhamburgermenuscreennewEvent, OpenhamburgermenuscreennewState> {
  OpenhamburgermenuscreennewBloc(OpenhamburgermenuscreennewState initialState)
      : super(initialState) {
    on<OpenhamburgermenuscreennewInitialEvent>(_onInitialize);
  }

  _onInitialize(
    OpenhamburgermenuscreennewInitialEvent event,
    Emitter<OpenhamburgermenuscreennewState> emit,
  ) async {}
}
