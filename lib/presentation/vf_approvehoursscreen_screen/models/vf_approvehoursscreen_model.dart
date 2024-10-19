import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/attendance.dart';
import '../../../core/app_export.dart';
import 'userprofilelist_item_model.dart';

/// This class defines the variables used in the [vf_approvehoursscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfApprovehoursscreenModel extends Equatable {
  final List<Attendance> shift1Attendees;
  final List<Attendance> shift2Attendees;
  final List<Attendance> filteredAttendees; // For search results

  final int totalAttendedHours;
  final int totalApprovedHours;

  VfApprovehoursscreenModel({
    this.shift1Attendees = const [],
    this.shift2Attendees = const [],
    this.filteredAttendees = const [],
    this.totalAttendedHours = 0,
    this.totalApprovedHours = 0,
  });

  // Get attendees for a specific shift
  List<Attendance> getAttendeesForShift(int shiftindex) {
    List<Attendance> attendees;
    if (shiftindex == 0) {
      attendees =
          filteredAttendees.isNotEmpty ? filteredAttendees : shift1Attendees;
    } else {
      attendees =
          filteredAttendees.isNotEmpty ? filteredAttendees : shift2Attendees;
    }
    return attendees.map((attendance) => attendance).toList();
  }

  // Helper method to calculate total hours (attended or approved)
  int calculateTotalHours(List<UserprofilelistItemModel> attendees,
      {bool approved = false}) {
    return attendees.fold(
        0,
        (total, attendee) =>
            total +
            (approved ? attendee.hoursApproved : attendee.hoursAttended));
  }

  VfApprovehoursscreenModel copyWith({
    List<Attendance>? shift1Attendees,
    List<Attendance>? shift2Attendees,
    List<Attendance>? filteredAttendees,
    int? totalAttendedHours,
    int? totalApprovedHours,
  }) {
    return VfApprovehoursscreenModel(
      shift1Attendees: shift1Attendees ?? this.shift1Attendees,
      shift2Attendees: shift2Attendees ?? this.shift2Attendees,
      filteredAttendees: filteredAttendees ?? this.filteredAttendees,
      totalAttendedHours: totalAttendedHours ?? this.totalAttendedHours,
      totalApprovedHours: totalApprovedHours ?? this.totalApprovedHours,
    );
  }

  @override
  List<Object?> get props => [
        shift1Attendees,
        shift2Attendees,
        filteredAttendees,
        totalAttendedHours,
        totalApprovedHours,
      ];
}
