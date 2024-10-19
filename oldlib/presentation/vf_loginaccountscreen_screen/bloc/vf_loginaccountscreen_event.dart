part of 'vf_loginaccountscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfLoginaccountscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfLoginaccountscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfLoginaccountscreen widget is first created.
class VfLoginaccountscreenInitialEvent extends VfLoginaccountscreenEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing password visibility

// ignore_for_file: must_be_immutable
class ChangePasswordVisibilityEvent extends VfLoginaccountscreenEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}

///Event for changing checkbox

// ignore_for_file: must_be_immutable
class ChangeCheckBoxEvent extends VfLoginaccountscreenEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}
