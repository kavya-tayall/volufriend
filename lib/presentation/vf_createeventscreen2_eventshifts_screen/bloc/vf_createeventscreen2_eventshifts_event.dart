part of 'vf_createeventscreen2_eventshifts_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfCreateeventscreen2Eventshifts widget.
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfCreateeventscreen2EventshiftsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateeventscreen2Eventshifts widget is first created.
class VfCreateeventscreen2EventshiftsInitialEvent
    extends VfCreateeventscreen2EventshiftsEvent {
  final Voluevents? orgEvent; // Optional parameter, can be null

  VfCreateeventscreen2EventshiftsInitialEvent({this.orgEvent});

  @override
  List<Object?> get props => [orgEvent];
}

/// Event for changing the start time of a specific shift.
class ChangeShiftStartTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final int shiftIndex;
  final DateTime startTime;

  ChangeShiftStartTimeEvent({
    required this.shiftIndex,
    required this.startTime,
  });

  @override
  List<Object?> get props => [shiftIndex, startTime];
}

/// Event for changing the end time of a specific shift.
class ChangeShiftEndTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final int shiftIndex;
  final DateTime endTime;

  ChangeShiftEndTimeEvent({
    required this.shiftIndex,
    required this.endTime,
  });

  @override
  List<Object?> get props => [shiftIndex, endTime];
}

/// Event for saving the shift details with updated data.
/// Event for saving the shift details
class SaveShiftDetailsEvent extends VfCreateeventscreen2EventshiftsEvent {
  SaveShiftDetailsEvent(); // No fields needed

  @override
  List<Object?> get props => [];
}

/// Event for fetching the shift details
class FetchShiftDetailsEvent extends VfCreateeventscreen2EventshiftsEvent {
  final Voluevents orgEvent;

  FetchShiftDetailsEvent({required this.orgEvent});

  @override
  List<Object?> get props => [orgEvent];
}

// Other imports and code...

class UpdateShift1StartTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final String starttime;

  UpdateShift1StartTimeEvent({required this.starttime});

  @override
  List<Object> get props => [starttime];
}

class UpdateShift2StartTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final String starttime;

  UpdateShift2StartTimeEvent({required this.starttime});

  @override
  List<Object> get props => [starttime];
}

class UpdateShift1EndTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final String endtime;

  UpdateShift1EndTimeEvent({required this.endtime});

  @override
  List<Object> get props => [endtime];
}

class UpdateShift2EndTimeEvent extends VfCreateeventscreen2EventshiftsEvent {
  final String endtime;

  UpdateShift2EndTimeEvent({required this.endtime});

  @override
  List<Object> get props => [endtime];
}

class UpdateShift1MaxParticipantsEvent
    extends VfCreateeventscreen2EventshiftsEvent {
  final int maxParticipants;

  UpdateShift1MaxParticipantsEvent({required this.maxParticipants});
}

// Other event classes...

class VfCreateeventscreen2ShiftsResetInitializationEvent
    extends VfCreateeventscreen2EventshiftsEvent {
  VfCreateeventscreen2ShiftsResetInitializationEvent();

  @override
  List<Object?> get props => [];
}
