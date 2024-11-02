part of 'vf_eventlist_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfHomescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfEventListScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetEventListScreenEvent extends VfEventListScreenEvent {}

/// Event to load the upcoming event list
class LoadUpcomingEventListEvent extends VfEventListScreenEvent {
  final String? userId;

  LoadUpcomingEventListEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

/// Event to load the upcoming event list
class LoadEventListForApprovalEvent extends VfEventListScreenEvent {
  final String? userId;

  LoadEventListForApprovalEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

/// Event that is dispatched when the VfHomescreen widget is first created.
class EventListScreenInitialEvent extends VfEventListScreenEvent {
  final String? userId;
  final String? role;
  final String? listType;
  EventListScreenInitialEvent({this.userId, this.role, this.listType});

  @override
  List<Object?> get props => [userId, role];
}

class CancelEventEvent extends VfEventListScreenEvent {
  final String eventId;
  final bool notifyParticipants;

  CancelEventEvent({required this.eventId, required this.notifyParticipants});

  @override
  List<Object?> get props => [eventId, notifyParticipants];
}

class LoadUpcomingInterestEventListEvent extends VfEventListScreenEvent {
  final String? userId;

  LoadUpcomingInterestEventListEvent({this.userId});

  @override
  List<Object?> get props => [userId];
}

class FilterEventsEvent extends VfEventListScreenEvent {
  final DateTimeRange? dateRange;
  final List<String> daysOfWeek;
  final String timeOfDay;

  FilterEventsEvent({
    this.dateRange,
    required this.daysOfWeek,
    required this.timeOfDay,
  });

  @override
  List<Object?> get props => [dateRange, daysOfWeek, timeOfDay];
}

class HighlightEvent extends VfEventListScreenEvent {
  final String eventId;

  HighlightEvent({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

class MarkEventAsCompletedEvent extends VfEventListScreenEvent {
  final String eventId;

  MarkEventAsCompletedEvent({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

class DeleteEvent extends VfEventListScreenEvent {
  final String eventId;

  DeleteEvent({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}

/// Event to trigger the loading of past events.
class LoadPastEventsEvent extends VfEventListScreenEvent {
  final String userId;
  final DateTime startDate; // Optional: Starting date to filter past events
  final DateTime endDate; // Optional: Ending date to filter past events

  LoadPastEventsEvent({
    required this.userId,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props =>
      [userId, startDate, endDate]; // Include in equality check
}
