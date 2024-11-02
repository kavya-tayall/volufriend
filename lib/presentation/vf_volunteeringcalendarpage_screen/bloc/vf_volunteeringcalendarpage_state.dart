part of 'vf_volunteeringcalendarpage_bloc.dart';

class VfVolunteeringcalendarpageState extends Equatable {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final List<Voluevents> selectedEvents;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime currentMonthStart;
  final DateTime currentMonthEnd;
  final int monthsFetched;
  final String Role;
  final String? userId;

  const VfVolunteeringcalendarpageState({
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.selectedEvents,
    this.rangeStart,
    this.rangeEnd,
    required this.currentMonthStart,
    required this.currentMonthEnd,
    required this.monthsFetched,
    required this.Role,
    this.userId,
  });

  VfVolunteeringcalendarpageState copyWith({
    DateTime? selectedDay,
    DateTime? focusedDay,
    CalendarFormat? calendarFormat,
    List<Voluevents>? selectedEvents,
    DateTime? rangeStart,
    DateTime? rangeEnd,
    DateTime? currentMonthStart,
    DateTime? currentMonthEnd,
    int? monthsFetched,
    String? Role,
    String? userId,
  }) {
    return VfVolunteeringcalendarpageState(
      selectedDay: selectedDay ?? this.selectedDay,
      focusedDay: focusedDay ?? this.focusedDay,
      calendarFormat: calendarFormat ?? this.calendarFormat,
      selectedEvents: selectedEvents ?? this.selectedEvents,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
      currentMonthStart: currentMonthStart ?? this.currentMonthStart,
      currentMonthEnd: currentMonthEnd ?? this.currentMonthEnd,
      monthsFetched: monthsFetched ?? this.monthsFetched,
      Role: Role ?? this.Role,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object?> get props => [
        selectedDay,
        focusedDay,
        calendarFormat,
        selectedEvents,
        rangeStart,
        rangeEnd,
        currentMonthStart,
        currentMonthEnd,
        monthsFetched,
        Role,
        userId,
      ];
}
