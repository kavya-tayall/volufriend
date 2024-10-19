part of 'vf_orgschedulescreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfOrgschedulescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfOrgschedulescreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfOrgschedulescreen widget is first created.
class VfOrgschedulescreenInitialEvent extends VfOrgschedulescreenEvent {
  @override
  List<Object?> get props => [];
}
