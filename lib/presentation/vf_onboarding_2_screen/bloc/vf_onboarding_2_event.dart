part of 'vf_onboarding_2_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfOnboarding2 widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfOnboarding2Event extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfOnboarding2 widget is first created.
class VfOnboarding2InitialEvent extends VfOnboarding2Event {
  @override
  List<Object?> get props => [];
}
