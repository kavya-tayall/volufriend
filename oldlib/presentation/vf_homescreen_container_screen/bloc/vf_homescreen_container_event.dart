part of 'vf_homescreen_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfHomescreenContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfHomescreenContainerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfHomescreenContainer widget is first created.
class VfHomescreenContainerInitialEvent extends VfHomescreenContainerEvent {
  @override
  List<Object?> get props => [];
}
