part of 'vf_homescreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfHomescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfHomescreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfHomescreen widget is first created.
class VfHomescreenInitialEvent extends VfHomescreenEvent {
  @override
  List<Object?> get props => [];
}
