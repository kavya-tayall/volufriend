part of 'org_event_bloc.dart';

class orgVoluEventState extends Equatable {
  final String eventId;
  final String shiftId1;
  final String shiftId2;
  final String userId;
  final bool isLoading;
  final bool findNewOpportunities;
  final bool scheduledEvents;
  final bool volunteerProfile;
  final bool attendanceReport;
  final bool approvehours;
  final bool attendeelist;
  final bool orgschedule;
  final bool eventsignup;
  final bool showallorgevents;
  final bool showalluserevents;
  final bool eventDetails;
  final bool manageEvents;
  final bool updateEvent;
  final Voluevents? eventSelected; // Nullable

  orgVoluEventState({
    this.eventId = '',
    this.shiftId1 = '',
    this.shiftId2 = '',
    this.userId = '',
    this.isLoading = false,
    this.findNewOpportunities = false,
    this.scheduledEvents = false,
    this.volunteerProfile = false,
    this.attendanceReport = false,
    this.approvehours = false,
    this.attendeelist = false,
    this.orgschedule = false,
    this.eventsignup = false,
    this.showallorgevents = false,
    this.showalluserevents = false,
    this.eventDetails = false,
    this.manageEvents = false,
    this.updateEvent = false,
    this.eventSelected, // Default to null
  });

  orgVoluEventState copyWith({
    String? eventId,
    String? shiftId1,
    String? shiftId2,
    String? userId,
    bool? isLoading,
    bool? findNewOpportunities,
    bool? scheduledEvents,
    bool? volunteerProfile,
    bool? attendanceReport,
    bool? approvehours,
    bool? attendeelist,
    bool? orgschedule,
    bool? eventsignup,
    bool? showallorgevents,
    bool? showalluserevents,
    bool? eventDetails,
    bool? manageEvents,
    bool? updateEvent,
    Voluevents? eventSelected,
  }) {
    return orgVoluEventState(
      eventId: eventId ?? this.eventId,
      shiftId1: shiftId1 ?? this.shiftId1,
      shiftId2: shiftId2 ?? this.shiftId2,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      findNewOpportunities: findNewOpportunities ?? this.findNewOpportunities,
      scheduledEvents: scheduledEvents ?? this.scheduledEvents,
      volunteerProfile: volunteerProfile ?? this.volunteerProfile,
      attendanceReport: attendanceReport ?? this.attendanceReport,
      approvehours: approvehours ?? this.approvehours,
      attendeelist: attendeelist ?? this.attendeelist,
      orgschedule: orgschedule ?? this.orgschedule,
      eventsignup: eventsignup ?? this.eventsignup,
      showallorgevents: showallorgevents ?? this.showallorgevents,
      showalluserevents: showalluserevents ?? this.showalluserevents,
      eventDetails: eventDetails ?? this.eventDetails,
      manageEvents: manageEvents ?? this.manageEvents,
      updateEvent: updateEvent ?? this.updateEvent,
      eventSelected: eventSelected ?? this.eventSelected,
    );
  }

  @override
  List<Object?> get props => [
        eventId,
        shiftId1,
        shiftId2,
        userId,
        isLoading,
        findNewOpportunities,
        scheduledEvents,
        volunteerProfile,
        attendanceReport,
        approvehours,
        attendeelist,
        orgschedule,
        eventsignup,
        showallorgevents,
        showalluserevents,
        eventDetails,
        manageEvents,
        updateEvent,
        eventSelected,
      ];
}
