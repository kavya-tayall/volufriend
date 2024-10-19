import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_loginaccountscreen_model.dart';
part 'vf_loginaccountscreen_event.dart';
part 'vf_loginaccountscreen_state.dart';

/// A bloc that manages the state of a VfLoginaccountscreen according to the event that is dispatched to it.
class VfLoginaccountscreenBloc
    extends Bloc<VfLoginaccountscreenEvent, VfLoginaccountscreenState> {
  VfLoginaccountscreenBloc(VfLoginaccountscreenState initialState)
      : super(initialState) {
    on<VfLoginaccountscreenInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<VfLoginaccountscreenState> emit,
  ) {
    emit(state.copyWith(
      isShowPassword: event.value,
    ));
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<VfLoginaccountscreenState> emit,
  ) {
    emit(state.copyWith(
      rememberMeCheckbox: event.value,
    ));
  }

  _onInitialize(
    VfLoginaccountscreenInitialEvent event,
    Emitter<VfLoginaccountscreenState> emit,
  ) async {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      isShowPassword: true,
      rememberMeCheckbox: false,
    ));
  }
}
