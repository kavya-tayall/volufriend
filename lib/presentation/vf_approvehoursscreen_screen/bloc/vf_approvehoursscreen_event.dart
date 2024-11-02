part of 'vf_approvehoursscreen_bloc.dart';

abstract class VfApprovehoursscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VfSubmitApprovehourEvent extends VfApprovehoursscreenEvent {
  final String approverId;
  final int shiftIndex;

  VfSubmitApprovehourEvent(this.approverId, this.shiftIndex);

  @override
  List<Object?> get props => [approverId, shiftIndex];
}

/// Initial Event to load the screen
class VfApprovehoursscreenInitialEvent extends VfApprovehoursscreenEvent {
  final String eventId;
  final String shiftId1;
  final String shiftId2;
  final String eventName;
  final String eventDate;

  VfApprovehoursscreenInitialEvent(this.eventId, this.shiftId1, this.shiftId2,
      this.eventName, this.eventDate);

  @override
  List<Object?> get props =>
      [eventId, shiftId1, shiftId2, eventName, eventDate];
}

/// Event to fetch attendees for a specific shift
class GetAttendeesForShiftEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final String eventId;

  GetAttendeesForShiftEvent(this.shiftId, this.eventId);

  @override
  List<Object?> get props => [shiftId, eventId];
}

/// Event to toggle the approval status of an attendee
class ToggleApproveRejectEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int attendeeIndex;
  final bool isApproved;
  final int shiftIndex;

  ToggleApproveRejectEvent({
    required this.shiftId,
    required this.attendeeIndex,
    required this.isApproved,
    required this.shiftIndex,
  });

  @override
  List<Object?> get props => [shiftId, attendeeIndex, isApproved, shiftIndex];
}

/// Event to update the approved hours for a specific attendee
class UpdateApprovedHoursEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int attendeeIndex;
  final int approvedHours;
  final int shiftIndex;

  UpdateApprovedHoursEvent({
    required this.shiftId,
    required this.attendeeIndex,
    required this.approvedHours,
    required this.shiftIndex,
  });

  @override
  List<Object?> get props =>
      [shiftId, attendeeIndex, approvedHours, shiftIndex];
}

/// Event to select all attendees for a shift
class SelectAllEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int shiftIndex;

  SelectAllEvent(this.shiftId, this.shiftIndex);

  @override
  List<Object?> get props => [shiftId];
}

/// Event to deselect all attendees for a shift
class DeselectAllEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int shiftIndex;

  DeselectAllEvent(this.shiftId, this.shiftIndex);

  @override
  List<Object?> get props => [shiftId, shiftIndex];
}

/// Event to approve hours for all attendees in the current shift
class ApproveAllHoursEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int shiftIndex;
  ApproveAllHoursEvent(this.shiftId, this.shiftIndex);

  @override
  List<Object?> get props => [shiftId, shiftIndex];
}

/// Event to reject hours for all attendees in the current shift
class RejectAllHoursEvent extends VfApprovehoursscreenEvent {
  final String shiftId;
  final int shiftIndex;
  final String approverId;
  RejectAllHoursEvent(this.shiftId, this.shiftIndex, this.approverId);

  @override
  List<Object?> get props => [shiftId, shiftIndex, approverId];
}
