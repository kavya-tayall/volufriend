import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'org_event_event.dart';
part 'org_event_state.dart';

class orgVoluEventBloc extends Bloc<orgVoluEventEvent, orgVoluEventState> {
  orgVoluEventBloc() : super(orgVoluEventState()) {
    on<CreateEvent>(_onLoadData);
    on<UpdateEvent>(_onUpdateData);
    on<findNewOpportunitiesEvent>(_onFindNewOpportunities);
    on<scheduledEventsEvent>(_onScheduledEvents);
    on<resetEvent>(_onResetEvent);
    on<volunteerProfileEvent>(_onVolunteerProfile);
    on<attendanceReportEvent>(_onAttendanceReport);
    on<approvehoursEvent>(_onApproveHours);
    on<attendeelistEvent>(_onAttendeeList);
    on<orgschedule>(_onOrgSchedule);
    on<eventsignupEvent>(_onEventSignup);
    on<showallorgeventsEvent>(_onShowAllOrgEvents);
    on<showallusereventsEvent>(_onShowAllUserEvents);
    on<eventdetailsEvent>(_onEventDetails);
    on<manageEventsEvent>(_onManageEvents);
  }

  // Handler for manageEvents event
  void _onManageEvents(
      manageEventsEvent event, Emitter<orgVoluEventState> emit) {
    print('manageEvents event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: true,
        updateEvent: false));
    print('manageEvents updated to: ${state.manageEvents}');
  }

  // Handler for eventdetails event

  void _onEventDetails(
      eventdetailsEvent event, Emitter<orgVoluEventState> emit) {
    print('eventdetails event received');
    emit(state.copyWith(
        eventId: event.eventId,
        eventSelected: event.selectedEvent,
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: true,
        manageEvents: false,
        updateEvent: false));
    print('eventdetails updated to: ${state.eventId}');
  }

  // Handler for showalluserevents event
  void _onShowAllUserEvents(
      showallusereventsEvent event, Emitter<orgVoluEventState> emit) {
    print('showalluserevents event received');
    emit(state.copyWith(
      eventId: '',
      userId: '',
      isLoading: false,
      findNewOpportunities: false,
      scheduledEvents: false,
      volunteerProfile: false,
      attendanceReport: false,
      approvehours: false,
      attendeelist: false,
      orgschedule: false,
      eventsignup: false,
      showalluserevents: true,
      showallorgevents: false,
      eventDetails: false,
      manageEvents: false,
      updateEvent: false,
    ));

    print('showalluserevents updated to: ${state.showalluserevents}');
  }

  // Handler for showallorgevents event
  void _onShowAllOrgEvents(
      showallorgeventsEvent event, Emitter<orgVoluEventState> emit) {
    print('showallorgevents event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: true,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('showallorgevents updated to: ${state.showallorgevents}');
  }

  // Handler for eventsignup event
  _onEventSignup(eventsignupEvent event, Emitter<orgVoluEventState> emit) {
    print('eventsignup event received');
    emit(state.copyWith(
        eventId: event.eventId,
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: true,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('eventsignup updated to: ${state.eventsignup}');
  }

  // Handler for orgschedule event
  void _onOrgSchedule(orgschedule event, Emitter<orgVoluEventState> emit) {
    print('orgschedule event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: true,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));

    print('orgschedule updated to: ${state.orgschedule}');
  }

  // Handler for attendeelist event
  void _onAttendeeList(
      attendeelistEvent event, Emitter<orgVoluEventState> emit) {
    print('attendeelist event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: true,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('attendeelist updated to: ${state.attendeelist}');
  }

  // Handler for approvehours event
  void _onApproveHours(
      approvehoursEvent event, Emitter<orgVoluEventState> emit) {
    print('approvehours event received');
    emit(state.copyWith(
        eventSelected: event.selectedEvent,
        eventId: event.eventId,
        userId: '',
        shiftId1: event.shiftId1,
        shiftId2: event.shiftId2,
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: true,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('approvehours updated to: ${state.approvehours}');
  }

  // Handler for attendanceReport event
  void _onAttendanceReport(
      attendanceReportEvent event, Emitter<orgVoluEventState> emit) {
    print('attendanceReport event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        attendanceReport: true,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('attendanceReport updated to: ${state.attendanceReport}');
  }

  // Handler for volunteerProfile event
  void _onVolunteerProfile(
      volunteerProfileEvent event, Emitter<orgVoluEventState> emit) {
    print('volunteerProfile event received');
    emit(state.copyWith(
        eventId: '',
        userId: event.userId,
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: true,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('volunteerProfile updated to: ${state.userId}');
  }

  // Handler for resetEvent event
  void _onResetEvent(resetEvent event, Emitter<orgVoluEventState> emit) {
    print('resetEvent event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('State reset');
  }

  // Handler for findNewOpportunities event
  void _onFindNewOpportunities(
      findNewOpportunitiesEvent event, Emitter<orgVoluEventState> emit) {
    print('findNewOpportunities event received');
    emit(state.copyWith(
        findNewOpportunities: true,
        scheduledEvents: false,
        isLoading: false,
        eventId: '',
        userId: '',
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('findNewOpportunities updated to: ${state.findNewOpportunities}');
  }

  // Handler for scheduledEvents event
  void _onScheduledEvents(
      scheduledEventsEvent event, Emitter<orgVoluEventState> emit) {
    print('scheduledEvents event received');
    emit(state.copyWith(
        scheduledEvents: true,
        findNewOpportunities: false,
        isLoading: false,
        eventId: '',
        userId: '',
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('scheduledEvents updated to: ${state.scheduledEvents}');
  }

  // Handler for LoadData event
  void _onLoadData(CreateEvent event, Emitter<orgVoluEventState> emit) async {
    print('LoadData event received');
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: true,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    await Future.delayed(const Duration(seconds: 2)); // Simulate data loading
    emit(state.copyWith(
        eventId: '',
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: false));
    print('Data loaded: ${state.eventId}');
  }

  // Handler for UpdateData event
  void _onUpdateData(UpdateEvent event, Emitter<orgVoluEventState> emit) {
    print('UpdateData event received with data: ${event.eventId}');
    emit(state.copyWith(
        eventId: event.eventId,
        eventSelected: event.selectedEvent,
        userId: '',
        isLoading: false,
        findNewOpportunities: false,
        scheduledEvents: false,
        volunteerProfile: false,
        attendanceReport: false,
        approvehours: false,
        attendeelist: false,
        orgschedule: false,
        eventsignup: false,
        showallorgevents: false,
        showalluserevents: false,
        eventDetails: false,
        manageEvents: false,
        updateEvent: true));

    print('Data updated to: ${state.eventId}');
  }
}
