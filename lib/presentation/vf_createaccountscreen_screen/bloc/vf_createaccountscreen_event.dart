part of 'vf_createaccountscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfCreateaccountscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfCreateaccountscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateaccountscreen widget is first created.
class VfCreateaccountscreenInitialEvent extends VfCreateaccountscreenEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing password visibility

// ignore_for_file: must_be_immutable
class ChangePasswordVisibilityEvent extends VfCreateaccountscreenEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}

///Event for changing checkbox

// ignore_for_file: must_be_immutable
class ChangeCheckBoxEvent extends VfCreateaccountscreenEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}
