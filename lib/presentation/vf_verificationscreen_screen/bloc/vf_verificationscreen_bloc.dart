import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/app_export.dart';
import '../models/vf_verificationscreen_model.dart';
part 'vf_verificationscreen_event.dart';
part 'vf_verificationscreen_state.dart';

/// A bloc that manages the state of a VfVerificationscreen according to the event that is dispatched to it.
class VfVerificationscreenBloc
    extends Bloc<VfVerificationscreenEvent, VfVerificationscreenState>
    with CodeAutoFill {
  VfVerificationscreenBloc(VfVerificationscreenState initialState)
      : super(initialState) {
    on<VfVerificationscreenInitialEvent>(_onInitialize);
    on<ChangeOTPEvent>(_changeOTP);
  }

  @override
  codeUpdated() {
    add(ChangeOTPEvent(code: code!));
  }

  _changeOTP(
    ChangeOTPEvent event,
    Emitter<VfVerificationscreenState> emit,
  ) {
    emit(state.copyWith(
      otpController: TextEditingController(text: event.code),
    ));
  }

  _onInitialize(
    VfVerificationscreenInitialEvent event,
    Emitter<VfVerificationscreenState> emit,
  ) async {
    emit(state.copyWith(
      otpController: TextEditingController(),
    ));
    listenForCode();
  }
}
