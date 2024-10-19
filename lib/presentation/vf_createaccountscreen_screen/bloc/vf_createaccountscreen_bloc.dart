import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/attendance.dart';
import '../../../core/app_export.dart';
import '../models/vf_createaccountscreen_model.dart';
part 'vf_createaccountscreen_event.dart';
part 'vf_createaccountscreen_state.dart';

/// A bloc that manages the state of a VfCreateaccountscreen according to the event that is dispatched to it.
class VfCreateaccountscreenBloc
    extends Bloc<VfCreateaccountscreenEvent, VfCreateaccountscreenState> {
  VfCreateaccountscreenBloc(VfCreateaccountscreenState initialState)
      : super(initialState) {
    on<VfCreateaccountscreenInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<VfCreateaccountscreenState> emit,
  ) {
    emit(state.copyWith(
      isShowPassword: event.value,
    ));
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<VfCreateaccountscreenState> emit,
  ) {
    emit(state.copyWith(
      termsAndConditionsCheckbox: event.value,
    ));
  }

  _onInitialize(
    VfCreateaccountscreenInitialEvent event,
    Emitter<VfCreateaccountscreenState> emit,
  ) async {
    emit(state.copyWith(
      firstNameFieldController: TextEditingController(),
      lastNameFieldController: TextEditingController(),
      emailFieldController: TextEditingController(),
      phoneNumberFieldController: TextEditingController(),
      passwordFieldController: TextEditingController(),
      isShowPassword: true,
      termsAndConditionsCheckbox: false,
    ));
  }
}
