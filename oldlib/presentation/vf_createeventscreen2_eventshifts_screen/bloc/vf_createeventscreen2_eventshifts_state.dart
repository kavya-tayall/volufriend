part of 'vf_createeventscreen2_eventshifts_bloc.dart';

/// Represents the state of VfCreateeventscreen2Eventshifts in the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen2EventshiftsState extends Equatable {
  VfCreateeventscreen2EventshiftsState(
      {this.shiftActivityInputController,
      this.shiftStartTimeController,
      this.shiftEndTimeController,
      this.shiftMaxParticipantsController,
      this.shiftActivityInput1Controller,
      this.shiftStartTime1Controller,
      this.shiftEndTime1Controller,
      this.shiftMaxParticipants1Controller,
      this.vfCreateeventscreen2EventshiftsModelObj});

  TextEditingController? shiftActivityInputController;

  TextEditingController? shiftStartTimeController;

  TextEditingController? shiftEndTimeController;

  TextEditingController? shiftMaxParticipantsController;

  TextEditingController? shiftActivityInput1Controller;

  TextEditingController? shiftStartTime1Controller;

  TextEditingController? shiftEndTime1Controller;

  TextEditingController? shiftMaxParticipants1Controller;

  VfCreateeventscreen2EventshiftsModel? vfCreateeventscreen2EventshiftsModelObj;

  @override
  List<Object?> get props => [
        shiftActivityInputController,
        shiftStartTimeController,
        shiftEndTimeController,
        shiftMaxParticipantsController,
        shiftActivityInput1Controller,
        shiftStartTime1Controller,
        shiftEndTime1Controller,
        shiftMaxParticipants1Controller,
        vfCreateeventscreen2EventshiftsModelObj
      ];
  VfCreateeventscreen2EventshiftsState copyWith({
    TextEditingController? shiftActivityInputController,
    TextEditingController? shiftStartTimeController,
    TextEditingController? shiftEndTimeController,
    TextEditingController? shiftMaxParticipantsController,
    TextEditingController? shiftActivityInput1Controller,
    TextEditingController? shiftStartTime1Controller,
    TextEditingController? shiftEndTime1Controller,
    TextEditingController? shiftMaxParticipants1Controller,
    VfCreateeventscreen2EventshiftsModel?
        vfCreateeventscreen2EventshiftsModelObj,
  }) {
    return VfCreateeventscreen2EventshiftsState(
      shiftActivityInputController:
          shiftActivityInputController ?? this.shiftActivityInputController,
      shiftStartTimeController:
          shiftStartTimeController ?? this.shiftStartTimeController,
      shiftEndTimeController:
          shiftEndTimeController ?? this.shiftEndTimeController,
      shiftMaxParticipantsController:
          shiftMaxParticipantsController ?? this.shiftMaxParticipantsController,
      shiftActivityInput1Controller:
          shiftActivityInput1Controller ?? this.shiftActivityInput1Controller,
      shiftStartTime1Controller:
          shiftStartTime1Controller ?? this.shiftStartTime1Controller,
      shiftEndTime1Controller:
          shiftEndTime1Controller ?? this.shiftEndTime1Controller,
      shiftMaxParticipants1Controller: shiftMaxParticipants1Controller ??
          this.shiftMaxParticipants1Controller,
      vfCreateeventscreen2EventshiftsModelObj:
          vfCreateeventscreen2EventshiftsModelObj ??
              this.vfCreateeventscreen2EventshiftsModelObj,
    );
  }
}
