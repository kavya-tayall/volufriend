part of 'vf_orgschedulescreen_bloc.dart';

/// Represents the state of VfOrgschedulescreen in the application.

// ignore_for_file: must_be_immutable
class VfOrgschedulescreenState extends Equatable {
  VfOrgschedulescreenState(
      {this.selectedDatesFromCalendar, this.vfOrgschedulescreenModelObj});

  VfOrgschedulescreenModel? vfOrgschedulescreenModelObj;

  List<DateTime?>? selectedDatesFromCalendar;

  @override
  List<Object?> get props =>
      [selectedDatesFromCalendar, vfOrgschedulescreenModelObj];
  VfOrgschedulescreenState copyWith({
    List<DateTime?>? selectedDatesFromCalendar,
    VfOrgschedulescreenModel? vfOrgschedulescreenModelObj,
  }) {
    return VfOrgschedulescreenState(
      selectedDatesFromCalendar:
          selectedDatesFromCalendar ?? this.selectedDatesFromCalendar,
      vfOrgschedulescreenModelObj:
          vfOrgschedulescreenModelObj ?? this.vfOrgschedulescreenModelObj,
    );
  }
}
