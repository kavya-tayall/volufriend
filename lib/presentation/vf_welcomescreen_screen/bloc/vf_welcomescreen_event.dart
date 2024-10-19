part of 'vf_welcomescreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfWelcomescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfWelcomescreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfWelcomescreen widget is first created.
class VfWelcomescreenInitialEvent extends VfWelcomescreenEvent {
  @override
  List<Object?> get props => [];
}
