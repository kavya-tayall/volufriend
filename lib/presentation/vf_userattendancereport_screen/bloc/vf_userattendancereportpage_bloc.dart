import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../presentation/vf_userattendancereport_screen/models/vf_userattendancereportpage_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:flutter/material.dart';

part 'vf_userattendancereportpage_event.dart';
part 'vf_userattendancereportpage_state.dart';

class VfUserattendancereportpageBloc extends Bloc<
    VfUserattendancereportpageEvent, VfUserattendancereportpageState> {
  final VolufriendCrudService vfCrudService;

  VfUserattendancereportpageBloc({
    required this.vfCrudService,
    required VfUserattendancereportpageState initialState,
  }) : super(initialState) {
    on<LoadAttendanceEvent>(_onLoadAttendance);
    on<UpdateAttendanceEvent>(_onUpdateAttendance);
    on<ToggleHomeOrgEvent>(_showHomeOrgName);
    on<UpdateDateRangeEvent>(_updateDateRange);
  }

  Future<void> _updateDateRange(
    UpdateDateRangeEvent event,
    Emitter<VfUserattendancereportpageState> emit,
  ) async {
    print('Date Range: ${event.dateRange}');
    emit(state.copyWith(attendanceDateRange: event.dateRange));
  }

  Future<void> _showHomeOrgName(
    ToggleHomeOrgEvent event,
    Emitter<VfUserattendancereportpageState> emit,
  ) async {
    emit(state.copyWith(showHomeOrgName: event.showHomeOrgName));
  }

  Future<void> _onLoadAttendance(
    LoadAttendanceEvent event,
    Emitter<VfUserattendancereportpageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final attendanceList = await vfCrudService
          .getAttendancesForUserOrVolunteer(userId: event.userId);
      emit(state.copyWith(
        isLoading: false,
        vfUserattendancereportpageModelObj:
            VfUserattendancereportpageModel(userAttendance: attendanceList),
        totalAttendance: attendanceList.length,
        showHomeOrgName: true,
        attendanceDateRange: event.attendanceDateRange,
        userName: event.username,
        userId: event.userId,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateAttendance(
    UpdateAttendanceEvent event,
    Emitter<VfUserattendancereportpageState> emit,
  ) async {
    emit(state.copyWith(
        isLoading: true)); // Optional: Show loading while updating
    try {
      // Uncomment and implement this if you want to update the attendance
      // await vfCrudService.updateAttendance(event.updatedAttendance);
      print('Update Attendance: ${event.attendanceDateRange}');
      // Reload the attendance list after the update
      final updatedList = await vfCrudService.getAttendancesForUserOrVolunteer(
          userId: event.userId,
          startDate: event.attendanceDateRange.start,
          endDate: event.attendanceDateRange.end);
      emit(state.copyWith(
        vfUserattendancereportpageModelObj:
            VfUserattendancereportpageModel(userAttendance: updatedList),
        totalAttendance: updatedList.length,
        isLoading: false,
        userName: event.username,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
