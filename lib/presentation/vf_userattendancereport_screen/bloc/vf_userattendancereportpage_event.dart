part of 'vf_userattendancereportpage_bloc.dart';

abstract class VfUserattendancereportpageEvent extends Equatable {
  const VfUserattendancereportpageEvent();

  @override
  List<Object?> get props => [];
}

// Event to load attendance data
class LoadAttendanceEvent extends VfUserattendancereportpageEvent {
  final String userId;
  final DateTimeRange attendanceDateRange;
  final String username;

  const LoadAttendanceEvent(
      {required this.userId,
      required this.attendanceDateRange,
      required this.username});

  @override
  List<Object> get props => [userId, attendanceDateRange];
}

// Event to update attendance data
class UpdateAttendanceEvent extends VfUserattendancereportpageEvent {
  final String userId;
  final DateTimeRange attendanceDateRange;
  final String username;

  const UpdateAttendanceEvent({
    required this.userId,
    required this.attendanceDateRange,
    required this.username,
  });

  @override
  List<Object?> get props => [userId, attendanceDateRange, username];
}

class ToggleHomeOrgEvent extends VfUserattendancereportpageEvent {
  final bool showHomeOrgName;

  const ToggleHomeOrgEvent(this.showHomeOrgName);

  @override
  List<Object> get props => [showHomeOrgName];
}

class UpdateDateRangeEvent extends VfUserattendancereportpageEvent {
  final DateTimeRange dateRange;

  const UpdateDateRangeEvent(this.dateRange);

  @override
  List<Object> get props => [dateRange];
}
