import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import '../models/userprofilelist_item_model.dart';
import '../models/vf_approvehoursscreen_model.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
part 'vf_approvehoursscreen_event.dart';
part 'vf_approvehoursscreen_state.dart';

class VfApprovehoursscreenBloc
    extends Bloc<VfApprovehoursscreenEvent, VfApprovehoursscreenState> {
  final VolufriendCrudService vfcrudService;

  VfApprovehoursscreenBloc({
    required VfApprovehoursscreenState initialState,
    required this.vfcrudService,
  }) : super(initialState) {
    on<VfApprovehoursscreenInitialEvent>(_onInitialize);
    on<GetAttendeesForShiftEvent>(_getAttendeesForShift);
    on<SelectAllEvent>(_selectAllAttendees);
    on<DeselectAllEvent>(_deselectAllAttendees);
    on<ToggleApproveRejectEvent>(_toggleApproval);
    on<ApproveAllHoursEvent>(_approveAllHours);
    on<RejectAllHoursEvent>(_rejectAllHours);
    on<UpdateApprovedHoursEvent>(_updateApprovedHours);
    on<VfSubmitApprovehourEvent>(_onSubmitApproveHours);
  }

  void _onSubmitApproveHours(
    VfSubmitApprovehourEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) async {
    List<Attendance> attendees;
    if (event.shiftIndex == 0) {
      attendees = state.vfApprovehoursscreenModelObj!.shift1Attendees;
    } else if (event.shiftIndex == 1) {
      attendees = state.vfApprovehoursscreenModelObj!.shift2Attendees;
    } else {
      attendees = [];
    }

    //final attendees = [...shift1Attendees, ...shift2Attendees];
    print('attendees: saving $attendees');
    if (attendees.isEmpty) {
      return;
    }

    final approvedAttendees = attendees
        .where((attendance) => attendance.isApproved)
        .map((attendance) => attendance.copyWith(
              approvedByApproverId: event.approverId,
              attendanceStatus: 'approved',
            ))
        .toList();

    final rejectedAttendees = attendees
        .where((attendance) => attendance.isRejected)
        .map((attendance) => attendance.copyWith(
              rejectedByApproverId: event.approverId,
              attendanceStatus: 'rejected',
            ))
        .toList();

    final updatedAttendees = [...approvedAttendees, ...rejectedAttendees];

    final result = await vfcrudService.saveAttendanceApproval(updatedAttendees);
/*
    if (result) {
      emit(state.copyWith(
        vfApprovehoursscreenModelObj:
            state.vfApprovehoursscreenModelObj?.copyWith(
          shift1Attendees: shift1Attendees,
          shift2Attendees: shift2Attendees,
        ),
      ));
    }*/
  }

  void _onInitialize(
    VfApprovehoursscreenInitialEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) async {
    // Initialize state with default or mock data
    print('VfApprovehoursscreenInitialEvent');
    emit(state.copyWith(
      vfApprovehoursscreenModelObj: (state.vfApprovehoursscreenModelObj ??
              VfApprovehoursscreenModel(
                shift1Attendees: [], // default value
                shift2Attendees: [], // default value
              ))
          .copyWith(
              shift1Attendees: [], // default value
              shift2Attendees: []), // default value
      searchController: state.searchController ?? TextEditingController(),
      isSelectedSwitch: false,
      eventDate: event.eventDate,
      eventName: event.eventName,
      shift1Id: event.shiftId1,
      shift2Id: event.shiftId2,
    ));
/*
    final List<Attendance> shift1Attendees =
        _mockUserProfiles('Shift1', 'Event1');
    print('shift1Attendees: $shift1Attendees');
    final List<Attendance> shift2Attendees =
        _mockUserProfiles('Shift2', 'Event1');
    print('shift2Attendees: $shift2Attendees');
*/

    final List<Attendance> eventAttendees =
        await vfcrudService.getAttendancesForApproval(eventId: event.eventId);

    final shiftId1 = event.shiftId1;
    final shiftId2 = event.shiftId2;
    print('eventAttendees: $eventAttendees');
    print('shiftId1: $shiftId1');
    print('shiftId2: $shiftId2');
    List<Attendance> shift1Attendances = eventAttendees
        .where((attendance) => attendance.shiftId == shiftId1)
        .toList();

    List<Attendance> shift2Attendances = eventAttendees
        .where((attendance) => attendance.shiftId == shiftId2)
        .toList();
    print('shift1Attendances: $shift1Attendances');
    print('shift2Attendances: $shift2Attendances');
    emit(state.copyWith(
      vfApprovehoursscreenModelObj: (state.vfApprovehoursscreenModelObj ??
              VfApprovehoursscreenModel(
                shift1Attendees: [], // default value
                shift2Attendees: [], // default value
              ))
          .copyWith(
              shift1Attendees: shift1Attendances,
              shift2Attendees: shift2Attendances),
      searchController: state.searchController ?? TextEditingController(),
      isSelectedSwitch: false,
    ));
  }

  void _getAttendeesForShift(
    GetAttendeesForShiftEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) async {
    final eventAttendees =
        await vfcrudService.getAttendancesForApproval(eventId: event.eventId);

    final shiftId1 = state.shift1Id;
    final shiftId2 = state.shift2Id;

    List<Attendance> shift1Attendances = eventAttendees
        .where((attendance) => attendance.shiftId == shiftId1)
        .toList();

    List<Attendance> shift2Attendances = eventAttendees
        .where((attendance) => attendance.shiftId == shiftId2)
        .toList();

    emit(state.copyWith(
      vfApprovehoursscreenModelObj:
          state.vfApprovehoursscreenModelObj?.copyWith(
        shift1Attendees: shift1Attendances,
        shift2Attendees: shift2Attendances,
      ),
    ));
  }

  void splitAttendanceByShiftId(
      List<Attendance> attendanceList, String shiftId1, String shiftId2) {
    // Filter attendanceList for each shift_id
    List<Attendance> shift1Attendances = attendanceList
        .where((attendance) => attendance.shiftId == shiftId1)
        .toList();

    List<Attendance> shift2Attendances = attendanceList
        .where((attendance) => attendance.shiftId == shiftId2)
        .toList();

    // Example: Print the results
    print('Shift 1 Attendances: $shift1Attendances');
    print('Shift 2 Attendances: $shift2Attendances');
  }

  void _selectAllAttendees(
    SelectAllEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    emit(state.copyWith(
        vfApprovehoursscreenModelObj:
            state.vfApprovehoursscreenModelObj?.copyWith(
      shift1Attendees: event.shiftIndex == 0
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift1Attendees,
      shift2Attendees: event.shiftIndex == 1
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift2Attendees,
    )));
  }

  void _deselectAllAttendees(
    DeselectAllEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    emit(state.copyWith(
        vfApprovehoursscreenModelObj:
            state.vfApprovehoursscreenModelObj?.copyWith(
      shift1Attendees: event.shiftIndex == 0
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift1Attendees,
      shift2Attendees: event.shiftIndex == 1
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift2Attendees,
    )));
  }

  void _toggleApproval(
    ToggleApproveRejectEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    updatedList[event.attendeeIndex] =
        updatedList[event.attendeeIndex].copyWith(
      isApproved: event.isApproved,
      isRejected: !event.isApproved,
    );
    emit(state.copyWith(
        vfApprovehoursscreenModelObj:
            state.vfApprovehoursscreenModelObj?.copyWith(
      shift1Attendees: event.shiftIndex == 0
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift1Attendees,
      shift2Attendees: event.shiftIndex == 1
          ? updatedList
          : state.vfApprovehoursscreenModelObj!.shift2Attendees,
    )));
  }

  void _approveAllHours(
    ApproveAllHoursEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    /*  updatedList = updatedList
        .map((item) =>
            item.copyWith(isApproved: true, hoursApproved: item.hoursAttended))
        .toList();*/

    print('updatedList: $updatedList');
    emit(state.copyWith(
        vfApprovehoursscreenModelObj: state.vfApprovehoursscreenModelObj
            ?.copyWith(
                shift1Attendees: event.shiftIndex == 0
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift1Attendees,
                shift2Attendees: event.shiftIndex == 1
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift2Attendees)));
  }

  void _rejectAllHours(
    RejectAllHoursEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    updatedList = updatedList
        .map((item) => item.copyWith(
            isApproved: false,
            isRejected: true,
            hoursRejected: item.hoursAttended,
            hoursApproved: 0))
        .toList();

    emit(state.copyWith(
        vfApprovehoursscreenModelObj: state.vfApprovehoursscreenModelObj
            ?.copyWith(
                shift1Attendees: event.shiftIndex == 0
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift1Attendees,
                shift2Attendees: event.shiftIndex == 1
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift2Attendees)));
  }

  void _updateApprovedHours(
    UpdateApprovedHoursEvent event,
    Emitter<VfApprovehoursscreenState> emit,
  ) {
    List<Attendance> updatedList = state.vfApprovehoursscreenModelObj!
        .getAttendeesForShift(event.shiftIndex);

    updatedList[event.attendeeIndex] =
        updatedList[event.attendeeIndex].copyWith(
      hoursApproved: event.approvedHours.toInt(),
      hoursRejected: updatedList[event.attendeeIndex].hoursAttended -
          event.approvedHours.toInt(),
    );
    emit(state.copyWith(
        vfApprovehoursscreenModelObj: state.vfApprovehoursscreenModelObj
            ?.copyWith(
                shift1Attendees: event.shiftIndex == 0
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift1Attendees,
                shift2Attendees: event.shiftIndex == 1
                    ? updatedList
                    : state.vfApprovehoursscreenModelObj!.shift2Attendees)));
  }

  List<Attendance> _mockUserProfiles(String shiftId, String eventId) {
    return List.generate(5, (index) {
      return Attendance(
          attendanceId: shiftId + 'A' + index.toString(),
          singupId: 'SignupId',
          userId: '$index',
          username: 'User $index',
          eventId: eventId,
          eventDate: DateTime.now().toIso8601String(),
          eventName: 'Event $index',
          shiftId: shiftId,
          shiftName: 'Shift $index',
          coordinatorName: 'Coordinator $index',
          coordinatorEmail: 'coordinator$index@example.com',
          hoursApproved: 0,
          hoursRejected: 0,
          organizationName: 'Organization $index',
          hoursAttended: 10 + index,
          isApproved: false,
          isRejected: false,
          attendanceStatus: 'Pending', // Add appropriate default value
          approvedByApproverId: 'ApproverId', // Add appropriate default value
          rejectedByApproverId: 'ApproverId'); // Add appropriate default value
    });
  }
}
