part of 'vf_edituserprofile_bloc.dart';

/// Represents the state of VfEdituserprofile in the application.

// ignore_for_file: must_be_immutable
class VfEdituserprofileState extends Equatable {
  VfEdituserprofileState(
      {this.firstNameFieldController,
      this.lastNameFieldController,
      this.emailFieldController,
      this.phoneNumberFieldController,
      this.selectedDropDownValue,
      this.vfEdituserprofileModelObj});

  TextEditingController? firstNameFieldController;

  TextEditingController? lastNameFieldController;

  TextEditingController? emailFieldController;

  TextEditingController? phoneNumberFieldController;

  SelectionPopupModel? selectedDropDownValue;

  VfEdituserprofileModel? vfEdituserprofileModelObj;

  @override
  List<Object?> get props => [
        firstNameFieldController,
        lastNameFieldController,
        emailFieldController,
        phoneNumberFieldController,
        selectedDropDownValue,
        vfEdituserprofileModelObj
      ];
  VfEdituserprofileState copyWith({
    TextEditingController? firstNameFieldController,
    TextEditingController? lastNameFieldController,
    TextEditingController? emailFieldController,
    TextEditingController? phoneNumberFieldController,
    SelectionPopupModel? selectedDropDownValue,
    VfEdituserprofileModel? vfEdituserprofileModelObj,
  }) {
    return VfEdituserprofileState(
      firstNameFieldController:
          firstNameFieldController ?? this.firstNameFieldController,
      lastNameFieldController:
          lastNameFieldController ?? this.lastNameFieldController,
      emailFieldController: emailFieldController ?? this.emailFieldController,
      phoneNumberFieldController:
          phoneNumberFieldController ?? this.phoneNumberFieldController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      vfEdituserprofileModelObj:
          vfEdituserprofileModelObj ?? this.vfEdituserprofileModelObj,
    );
  }
}
