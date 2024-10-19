part of 'vf_homescreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfHomescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfHomescreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event to load the upcoming event list
class LoadUpcomingEventListEvent extends VfHomescreenEvent {
  final String? userId;

  LoadUpcomingEventListEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class CancelEventFromListEvent extends VfHomescreenEvent {
  final String eventId;
  final bool notifyParticipants;

  CancelEventFromListEvent(
      {required this.eventId, required this.notifyParticipants});

  @override
  List<Object?> get props => [eventId, notifyParticipants];
}

class LoadUpcomingInterestEventListEvent extends VfHomescreenEvent {
  final String? userId;

  LoadUpcomingInterestEventListEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

/// Event that is dispatched when the VfHomescreen widget is first created.
class VfHomescreenInitialEvent extends VfHomescreenEvent {
  final String? userId;
  final String? role;

  VfHomescreenInitialEvent({this.userId, this.role});

  @override
  List<Object?> get props => [userId, role];
}

/// Event for when an upcoming event is tapped
class UpcomingEventTappedEvent extends VfHomescreenEvent {
  final String eventId;

  UpcomingEventTappedEvent({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

/// Event for when an upcoming event is swiped/dismissed
class UpcomingEventDismissedEvent extends VfHomescreenEvent {
  final String eventId;

  UpcomingEventDismissedEvent({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}
