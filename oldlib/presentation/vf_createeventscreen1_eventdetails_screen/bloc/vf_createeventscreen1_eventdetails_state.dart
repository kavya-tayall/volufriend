part of 'vf_createeventscreen1_eventdetails_bloc.dart';

/// Represents the state of VfCreateeventscreen1Eventdetails in the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen1EventdetailsState extends Equatable {
  VfCreateeventscreen1EventdetailsState(
      {this.titleInputController,
      this.venueInputController,
      this.eventDateInputController,
      this.minimumAgeInputController,
      this.registrationDeadlineInputController,
      this.selectedDropDownValue,
      this.vfCreateeventscreen1EventdetailsModelObj});

  TextEditingController? titleInputController;

  TextEditingController? venueInputController;

  TextEditingController? eventDateInputController;

  TextEditingController? minimumAgeInputController;

  TextEditingController? registrationDeadlineInputController;

  SelectionPopupModel? selectedDropDownValue;

  VfCreateeventscreen1EventdetailsModel?
      vfCreateeventscreen1EventdetailsModelObj;

  @override
  List<Object?> get props => [
        titleInputController,
        venueInputController,
        eventDateInputController,
        minimumAgeInputController,
        registrationDeadlineInputController,
        selectedDropDownValue,
        vfCreateeventscreen1EventdetailsModelObj
      ];
  VfCreateeventscreen1EventdetailsState copyWith({
    TextEditingController? titleInputController,
    TextEditingController? venueInputController,
    TextEditingController? eventDateInputController,
    TextEditingController? minimumAgeInputController,
    TextEditingController? registrationDeadlineInputController,
    SelectionPopupModel? selectedDropDownValue,
    VfCreateeventscreen1EventdetailsModel?
        vfCreateeventscreen1EventdetailsModelObj,
  }) {
    return VfCreateeventscreen1EventdetailsState(
      titleInputController: titleInputController ?? this.titleInputController,
      venueInputController: venueInputController ?? this.venueInputController,
      eventDateInputController:
          eventDateInputController ?? this.eventDateInputController,
      minimumAgeInputController:
          minimumAgeInputController ?? this.minimumAgeInputController,
      registrationDeadlineInputController:
          registrationDeadlineInputController ??
              this.registrationDeadlineInputController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      vfCreateeventscreen1EventdetailsModelObj:
          vfCreateeventscreen1EventdetailsModelObj ??
              this.vfCreateeventscreen1EventdetailsModelObj,
    );
  }
}
