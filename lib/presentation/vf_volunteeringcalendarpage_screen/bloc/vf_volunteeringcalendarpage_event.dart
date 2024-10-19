part of 'vf_volunteeringcalendarpage_bloc.dart';

abstract class VfVolunteeringcalendarpageEvent extends Equatable {
  const VfVolunteeringcalendarpageEvent();

  @override
  List<Object?> get props => [];
}

class InitializeCalendarEvent extends VfVolunteeringcalendarpageEvent {
  final String userId;
  final DateTime currentDate;
  final String role;

  const InitializeCalendarEvent(
      {required this.userId, required this.currentDate, required this.role});

  @override
  List<Object?> get props => [userId, currentDate, role];
}

class SelectDayEvent extends VfVolunteeringcalendarpageEvent {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final String userId;
  final String Role;

  const SelectDayEvent(
      this.selectedDay, this.focusedDay, this.userId, this.Role);

  @override
  List<Object?> get props => [selectedDay, focusedDay, userId];
}

class ChangeCalendarFormatEvent extends VfVolunteeringcalendarpageEvent {
  final CalendarFormat format;

  const ChangeCalendarFormatEvent(this.format);

  @override
  List<Object?> get props => [format];
}

class FetchMoreEventsEvent extends VfVolunteeringcalendarpageEvent {
  final String userId;
  final DateTime newEndDate;
  final String role;

  const FetchMoreEventsEvent(this.userId, this.newEndDate, this.role);

  @override
  List<Object?> get props => [userId, newEndDate, role];
}
