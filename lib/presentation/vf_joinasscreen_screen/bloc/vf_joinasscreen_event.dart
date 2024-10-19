part of 'vf_joinasscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfJoinasscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfJoinasscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfJoinasscreen widget is first created.
class VfJoinasscreenInitialEvent extends VfJoinasscreenEvent {
  @override
  List<Object?> get props => [];
}

/// Event dispatched when the user chooses to join as a volunteer.
class JoinAsVolunteerEvent extends VfJoinasscreenEvent {
  @override
  List<Object?> get props => [];
}

/// Event dispatched when the user chooses to join as an organization.
class JoinAsOrganizationEvent extends VfJoinasscreenEvent {
  @override
  List<Object?> get props => [];
}
