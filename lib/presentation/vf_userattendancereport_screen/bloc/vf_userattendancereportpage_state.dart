part of 'vf_userattendancereportpage_bloc.dart';

// ignore_for_file: must_be_immutable
class VfUserattendancereportpageState extends Equatable {
  final VfUserattendancereportpageModel? vfUserattendancereportpageModelObj;
  final String errorMessage;
  final String successMessage;
  final String userId;
  final String userName;
  final int totalAttendance;
  final bool isLoading;
  final bool showHomeOrgName;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTimeRange attendanceDateRange;

  VfUserattendancereportpageState({
    this.vfUserattendancereportpageModelObj,
    this.errorMessage = '',
    this.successMessage = '',
    this.userId = '',
    this.userName = '',
    this.totalAttendance = 0,
    this.isLoading = false,
    this.showHomeOrgName = false,
    this.startDate,
    this.endDate,
    DateTimeRange? attendanceDateRange,
  }) : attendanceDateRange = attendanceDateRange ??
            DateTimeRange(start: DateTime(2000), end: DateTime(2000));

  @override
  List<Object?> get props => [
        vfUserattendancereportpageModelObj,
        errorMessage,
        successMessage,
        userId,
        userName,
        totalAttendance,
        isLoading,
        showHomeOrgName,
        startDate,
        endDate,
        attendanceDateRange,
      ];

  // Create a copy of the current state, with updated values where necessary
  VfUserattendancereportpageState copyWith({
    VfUserattendancereportpageModel? vfUserattendancereportpageModelObj,
    String? errorMessage,
    String? successMessage,
    String? userId,
    String? userName,
    int? totalAttendance,
    bool? isLoading,
    bool? showHomeOrgName,
    DateTime? startDate,
    DateTime? endDate,
    DateTimeRange? attendanceDateRange, // Add this field here
  }) {
    return VfUserattendancereportpageState(
      vfUserattendancereportpageModelObj: vfUserattendancereportpageModelObj ??
          this.vfUserattendancereportpageModelObj,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      totalAttendance: totalAttendance ?? this.totalAttendance,
      isLoading: isLoading ?? this.isLoading,
      showHomeOrgName: showHomeOrgName ?? this.showHomeOrgName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      attendanceDateRange: attendanceDateRange ??
          this.attendanceDateRange, // Correctly copy the attendanceDateRange
    );
  }
}
