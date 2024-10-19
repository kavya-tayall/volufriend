part of 'vf_createorgscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfCreateorgscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfCreateorgscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateorgscreen widget is first created.
class VfCreateorgscreenInitialEvent extends VfCreateorgscreenEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing checkbox

// ignore_for_file: must_be_immutable
class ChangeCheckBoxEvent extends VfCreateorgscreenEvent {
  ChangeCheckBoxEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}
