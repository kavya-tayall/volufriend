part of 'vf_orgschedulescreen_bloc.dart';

/// Represents the state of VfOrgschedulescreen in the application.

// ignore_for_file: must_be_immutable
class VfOrgschedulescreenState extends Equatable {
  final List<Voluevents>?
      eventsForSelectedDay; // List of events for the selected day
  final List<DateTime?> selectedDatesFromCalendar; // List of selected dates

  VfOrgschedulescreenState({
    this.eventsForSelectedDay,
    this.selectedDatesFromCalendar = const [], // Default to an empty list
  });

  @override
  List<Object?> get props => [eventsForSelectedDay, selectedDatesFromCalendar];

  VfOrgschedulescreenState copyWith({
    List<Voluevents>? eventsForSelectedDay,
    List<DateTime?>? selectedDatesFromCalendar,
  }) {
    return VfOrgschedulescreenState(
      eventsForSelectedDay: eventsForSelectedDay ?? this.eventsForSelectedDay,
      selectedDatesFromCalendar:
          selectedDatesFromCalendar ?? this.selectedDatesFromCalendar,
    );
  }
}
