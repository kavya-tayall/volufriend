import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_orgschedulescreen_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
part 'vf_orgschedulescreen_event.dart';
part 'vf_orgschedulescreen_state.dart';

/// A bloc that manages the state of a VfOrgschedulescreen according to the event that is dispatched to it.
class VfOrgschedulescreenBloc
    extends Bloc<VfOrgschedulescreenEvent, VfOrgschedulescreenState> {
  VfOrgschedulescreenBloc(VfOrgschedulescreenState initialState)
      : super(initialState) {
    on<VfOrgschedulescreenInitialEvent>(_onInitialize);
    on<CalendarDateChangedEvent>(_onCalendarDateChanged);
  }

  _onInitialize(
    VfOrgschedulescreenInitialEvent event,
    Emitter<VfOrgschedulescreenState> emit,
  ) async {}

  void _onCalendarDateChanged(
      CalendarDateChangedEvent event, Emitter<VfOrgschedulescreenState> emit) {
    // Fetch events for the selected day (this can be from an API or local data)
    final eventsForDay = fetchEventsForDay(
        event.selectedDates.first); // Fetch events for the selected day

    emit(state.copyWith(
      selectedDatesFromCalendar: event.selectedDates,
      eventsForSelectedDay: eventsForDay,
    ));
  }

  List<Voluevents> fetchEventsForDay(DateTime selectedDate) {
    // This is a simulation of fetching events from an API or local data
    // In a real app, this would be replaced with a call to a service
    final List<Voluevents> events = [
      Voluevents(
        eventId: '1',
        title: 'Event 1',
        description: 'Description of Event 1',
        startDate: selectedDate,
        coordinator: Coordinator(
          name: 'Coordinator 1',
          email: 'coordinator1@example.com',
          phone: '123-456-7890',
        ),
        shifts: [
          Shift(
            shiftId: '1',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 9, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 12, 0),
            activity: 'Activity 1',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
          Shift(
            shiftId: '2',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 13, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 17, 0),
            activity: 'Activity 2',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
        ],
      ),
      Voluevents(
        eventId: '2',
        title: 'Event 2',
        description: 'Description of Event 2',
        startDate: selectedDate,
        coordinator: Coordinator(
          name: 'Coordinator 2',
          email: 'coordinator1@example.com',
          phone: '123-456-7890',
        ),
        shifts: [
          Shift(
            shiftId: '3',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 9, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 12, 0),
            activity: 'Activity 3',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
          Shift(
            shiftId: '4',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 13, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 17, 0),
            activity: 'Activity 4',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
        ],
      ),
      Voluevents(
        eventId: '3',
        title: 'Event 3',
        description: 'Description of Event 3',
        startDate: selectedDate,
        coordinator: Coordinator(
          name: 'Coordinator 3',
          email: 'coordinator1@example.com',
          phone: '123-456-7890',
        ),
        shifts: [
          Shift(
            shiftId: '5',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 9, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 12, 0),
            activity: 'Activity 5',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
          Shift(
            shiftId: '6',
            startTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 13, 0),
            endTime: DateTime(
                selectedDate.year, selectedDate.month, selectedDate.day, 17, 0),
            activity: 'Activity 6',
            maxNumberOfParticipants: 10,
            numberOfParticipants: 5,
            minAge: 18,
          ),
        ],
      ),
    ];
    return events;
  }
}
