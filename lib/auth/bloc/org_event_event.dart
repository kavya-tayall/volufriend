part of 'org_event_bloc.dart';

abstract class orgVoluEventEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateEvent extends orgVoluEventEvent {}

class eventsignupEvent extends orgVoluEventEvent {
  final String? eventId;
  eventsignupEvent(this.eventId);

  @override
  List<Object> get props => [eventId ?? ''];
}

class findNewOpportunitiesEvent extends orgVoluEventEvent {}

class showallusereventsEvent extends orgVoluEventEvent {}

class showallorgeventsEvent extends orgVoluEventEvent {}

class scheduledEventsEvent extends orgVoluEventEvent {}

class attendanceReportEvent extends orgVoluEventEvent {}

class manageEventsEvent extends orgVoluEventEvent {}

class approvehoursEvent extends orgVoluEventEvent {
  final String eventId;
  final String shiftId1;
  final String shiftId2;
  final Voluevents selectedEvent;
  approvehoursEvent(
      this.eventId, this.shiftId1, this.shiftId2, this.selectedEvent);

  @override
  List<Object> get props => [eventId, shiftId1, shiftId2, selectedEvent];
}

class eventdetailsEvent extends orgVoluEventEvent {
  final String eventId;
  final Voluevents selectedEvent;
  eventdetailsEvent(this.eventId, this.selectedEvent);

  @override
  List<Object> get props => [eventId, selectedEvent];
}

class attendeelistEvent extends orgVoluEventEvent {}

class orgschedule extends orgVoluEventEvent {}

class volunteerProfileEvent extends orgVoluEventEvent {
  final String userId;

  volunteerProfileEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class resetEvent extends orgVoluEventEvent {}

class UpdateEvent extends orgVoluEventEvent {
  final String eventId;
  final Voluevents selectedEvent;

  UpdateEvent(this.eventId, this.selectedEvent);

  @override
  List<Object> get props => [eventId, selectedEvent];
}
