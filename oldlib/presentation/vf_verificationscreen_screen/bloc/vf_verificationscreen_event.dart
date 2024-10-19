part of 'vf_verificationscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfVerificationscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfVerificationscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfVerificationscreen widget is first created.
class VfVerificationscreenInitialEvent extends VfVerificationscreenEvent {
  @override
  List<Object?> get props => [];
}

///event for OTP auto fill

// ignore_for_file: must_be_immutable
class ChangeOTPEvent extends VfVerificationscreenEvent {
  ChangeOTPEvent({required this.code});

  String code;

  @override
  List<Object?> get props => [code];
}
